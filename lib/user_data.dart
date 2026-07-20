import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vendasagrindus/data_helper.dart';
import 'package:vendasagrindus/model/cartItem.dart';
import 'package:vendasagrindus/model/cliente.dart';
import 'package:vendasagrindus/model/condPagto.dart';
import 'package:vendasagrindus/model/grupoProdutos.dart';
import 'package:vendasagrindus/model/grupos.dart';
import 'package:vendasagrindus/model/listaPreco.dart';
import 'package:vendasagrindus/model/pedidoItem.dart';
import 'package:vendasagrindus/model/pedidoMestre.dart';
import 'package:vendasagrindus/model/pedidoMestreFull.dart';
import 'package:vendasagrindus/model/produto.dart';
import 'package:vendasagrindus/model/produtosImagem.dart';
import 'package:vendasagrindus/model/tipoMovimento.dart';
import 'package:vendasagrindus/model/vendedor.dart';
import 'package:darq/darq.dart';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;

class UserData extends ChangeNotifier {
  var _db = DataHelper();
  late String baseUrl;
  Vendedor vendedor = Vendedor();
  List<Cliente> clientes = <Cliente>[];
  List<Produto> produtos = <Produto>[];
  Map<int, List<ListaPreco>> grupoPreco = <int, List<ListaPreco>>{};
  List<int> listNumber = <int>[];
  Map<String, CartItem> cart = <String, CartItem>{};
  List<dynamic> pedidosSalvos = [];
  Map<String, int> backupAmount = <String, int>{};
  List<PedidoMestreFull> allData = <PedidoMestreFull>[];
  List<Grupos> grupos = [
    Grupos(dESCRICAO: 'TODOS', gRUPO: ''),
  ];

  Future<void> loginSetup(String uid) async {
    var documentSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    var data = documentSnapshot.data()!;
    String url = data['url'] as String;
    String vendedorCode = data['vendedor'] as String;
    baseUrl = url;
    await getVendedor(vendedorCode);
    await getClientes();
    await getProdutosEGrupos(vendedorCode);
  }

  signOut() async {
    //Função de desconexão
    await clearSavedOrders();
    _resetData();
  }

  getVendedor(String id) async {
    var dadosVendedor =
        await _db.getData(_db.getVendedor, baseUrl, additionalData1: id);
    if (dadosVendedor[0] is String) {
      throw Exception('Este vendedor não existe.');
    }
    vendedor = Vendedor.fromJson(dadosVendedor[0]);

    print("getVendedor success");
    notifyListeners();
  }

  Future<void> updateVendedor() async {
    Iterable jsonData = await _db.getData(
        _db.getVendedor, baseUrl,
        additionalData1: vendedor.vENDEDOR ?? '');
    vendedor = Vendedor.fromJson(jsonData.first);
    notifyListeners();
  }

  Future<void> getClientes() async {
    Iterable jsonData = await _db.getData(
        _db.getClientes, baseUrl,
        additionalData1: vendedor.vENDEDOR ?? '');
    clientes = jsonData.map((model) => Cliente.fromJson(model)).toList();
    await _getTipoMovimento();
    await _getCondPagto();

    print("getClientes success");
    notifyListeners();
  }

  Cliente? getClienteFromCod(String codCliente) {
    //Função para recuperar o cliente dado seu código
    return clientes.singleWhereOrNull((element) => element.cLIENTE == codCliente);
  }

  Cliente getClienteFromPedidosSalvos(int index) {
    String cliente = pedidosSalvos[index]['CLIENTE'];
    return clientes.singleWhere((element) => element.cLIENTE == cliente);
  }

  bool isClientRisk(Cliente client) => client.rISCO != 1;

  getProdutos() async {
    Iterable listaProdutos = await _db.getData(_db.getProdutos, baseUrl);
    produtos = listaProdutos.map((model) => Produto.fromJson(model)).toList();
  }

  _getGrupoProduto() async {
    //Ao recuperar os grupos, são associados aos produtos na mesma função
    List<GrupoProdutos> grupoProdutos = <GrupoProdutos>[];
    var listaGP = await _db.getData(_db.getGrupoProdutos, baseUrl);
    for (var item in listaGP) {
      grupoProdutos.add(GrupoProdutos.fromJson(item));
    }
    for (var produto in produtos) {
      var element = grupoProdutos.firstWhereOrNull(
          (element) => (element.cPRODPALM == produto.cPRODPALM));
      if (element != null) {
        produto.gRUPO = element.gRUPO;
      } else {
        print('Merge error');
      }
    }
  }

  _getGrupos() async {
    //Ao recuperar os grupos, são associados aos produtos na mesma função
    Iterable listaGr = await _db.getData(_db.getGrupos, baseUrl);
    for (var item in listaGr) {
      grupos.add(Grupos.fromJson(item));
    }

    for (var grupo in grupos) {
      for (var produto in produtos) {
        if (produto.gRUPO == grupo.gRUPO) {
          produto.gRUPODESC = grupo.dESCRICAO;
        }
      }
    }
  }

  atribuirPreco(int key) {
    //Função para atribuir o preço do produto a partir da lista de preço de número int key
    for (var item in grupoPreco[key]!) {
      for (var produto in produtos) {
        if (produto.cPRODPALM == item.cPRODPALM) {
          produto.pRECO = item.pRECO;
        }
      }
    }
  }

  removeEmptyItens() {
    List<String> removeValues = [];
    for (var item in cart.values) {
      if (item.amount <= 0) {
        removeValues.add(item.code ?? '');
      }
    }
    for (var code in removeValues) {
      cart.remove(code);
    }
    notifyListeners();
  }

  removerQtde(Produto produto) {
    //Função para diminuir quantidade de determinado Produto produto no carrinho
    //Se a quantidade chegar a zero o item será removido do carrinho
    if (cart.containsKey(produto.cPRODPALM)) {
      if (cart[produto.cPRODPALM]!.amount > 0) {
        cart[produto.cPRODPALM]!.amount--;
      }
      if (cart[produto.cPRODPALM]!.amount == 0) {
        cart.remove(produto.cPRODPALM);
      }
      notifyListeners();
    }
  }

  void addCartItem(Produto produto) {
    String key = produto.cPRODPALM ?? '';
    cart.putIfAbsent(key,
        () => CartItem(code: produto.cPRODPALM, name: produto.dESCRICAO,
        barCode: produto.cODBARRA, image: produto.iMAGEMURL,
        weight: produto.pESOBRUTO, packageWeight: produto.rESERVADO9,
        group: produto.gRUPO, unity: produto.uNIDADE,
        amount: 0, price: produto.pRECO));
    cart[key]!.amount++;
    notifyListeners();
  }

  void addNumberedCartItem(Produto produto, int amount) {
    String key = produto.cPRODPALM ?? '';
    cart.putIfAbsent(key,
        () => CartItem(code: produto.cPRODPALM, name: produto.dESCRICAO,
        barCode: produto.cODBARRA, image: produto.iMAGEMURL,
        weight: produto.pESOBRUTO, packageWeight: produto.rESERVADO9,
        group: produto.gRUPO, unity: produto.uNIDADE,
        amount: 0, price: produto.pRECO));
    cart[key]!.amount = amount;
    notifyListeners();
  }

  getCart(List<CartItem> cartItems, {bool backup = false}) {
    for (var item in cartItems) {
      String key = item.code ?? '';
      cart.putIfAbsent(key, () => item);
    }
    if (backup) {
      cart.forEach((key, value) {
        if (value.amount < 1) {
          cart.remove(key);
        }
      });
      notifyListeners();
    }
  }

  double getTotal() {
    double sum = 0.0;
    for (var item in cart.values) {
      sum += item.total;
    }
    return sum;
  }

  double getPesoTotal() {
    double sum = 0.0;
    for (var item in cart.values) {
      sum += item.pesoTotal;
    }
    return sum;
  }

  _atribuirImagens() async {
    //Função para atribuir imagens e descrição dos produtos
    //São recuperadas por função get e associados a classe Produto
    //imagem = String url
    List<ProdutoImagem> imageList = <ProdutoImagem>[];
    var aux = await _db.getData(_db.getProdutosImagem, baseUrl);
    for (var item in aux) {
      imageList.add(ProdutoImagem.fromJson(item));
    }
    for (var item in imageList) {
      for (var produto in produtos) {
        if (item.cODIGO == produto.cODBARRA) {
          produto.iMAGEMURL = item.uRL;
          produto.dESCEXTENSO = item.dESCRICAO;
        }
      }
    }
  }

  _getTipoMovimento() async {
    //Ao recuperar o tipo movimento, é associado ao cliente na mesma função
    List<TipoMovimento> listaMovimentos = <TipoMovimento>[];
    Iterable aux = await _db.getData(_db.getTipoMovimento, baseUrl);
    listaMovimentos = aux.map((model) => TipoMovimento.fromJson(model)).toList();
    for (var item in listaMovimentos) {
      for (var cliente in clientes) {
        if (cliente.tIPOCLI == item.tIPOCLI) {
          cliente.tIPOMOVIMENTO = item;
        }
      }
    }
  }

  _getCondPagto() async {
    //Ao recuperar a condição de pagamento, é associada ao cliente na mesma função
    List<CondPagto> listaCondPagtos = <CondPagto>[];
    Iterable aux = await _db.getData(_db.getCondPagto, baseUrl);
    listaCondPagtos = aux.map((model) => CondPagto.fromJson(model)).toList();
    for (var item in listaCondPagtos) {
      for (var cliente in clientes) {
        if (cliente.cONDPAGTO == item.cONDPAGTO) {
          cliente.cONDPAGTOobj = item;
        }
      }
    }
  }

  Future<List<PedidoMestre>?> getPedidoMestre(String codCliente) async {
    Iterable aux = await _db.getData(_db.getPedidoMestre, baseUrl,
        additionalData1: vendedor.vENDEDOR ?? '', additionalData2: codCliente);
    try {
      List<PedidoMestre> pedidosMestre =
          aux.map((model) => PedidoMestre.fromJson(model)).toList();
      return pedidosMestre;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<PedidoItem>?> getPedidoItem(String numeroDoPedido) async {
    try {
      Iterable aux = await _db.getData(_db.getPedidoItem, baseUrl,
          additionalData1: numeroDoPedido);
      return aux.map((model) => PedidoItem.fromJson(model)).toList();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> getPedidoMestreFull() async {
    Iterable jsonData = await _db.getData(_db.getPedidoMestreFull, baseUrl,
        additionalData1: vendedor.vENDEDOR ?? '');
    try {
      List<PedidoMestreFull> pedidosMestreFull =
          jsonData.map((model) => PedidoMestreFull.fromJson(model)).toList();
      allData = pedidosMestreFull;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Produto getProdutoFromProdPalm(String productId) {
    return produtos
        .firstWhere((item) => (item.cPRODPALM ?? '').trim() == productId);
  }

  Future<File> _getFile() async {
    //Função para para recuperar os pedidos salvos, se não houver arquivo, o mesmo será criado
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/orders.json");
  }

  saveFile() async {
    //Função genérica para salvar o arquivo independente da mudança
    var file = await _getFile();
    String data = json.encode(pedidosSalvos);
    file.writeAsString(data);
  }

  saveOrder(PedidoMestre newOrder) async {
    //Função para salvar o pedido no arquivo
    var item = newOrder.toJson();
    pedidosSalvos.add(item);
    saveFile();
    notifyListeners();
  }

  getOrders() async {
    //Função para recuperar os pedidos do arquivo
    try {
      final file = await _getFile();
      var data = await file.readAsString();
      pedidosSalvos = json.decode(data);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  removeOrder(int index) async {
    //Função para remover o pedido no arquivo
    pedidosSalvos.removeAt(index);
    saveFile();
    notifyListeners();
  }

  sendAllOrders() async {
    //Função para enviar todos pedidos salvos no arquivo
    //Se a operação for completa, serão removidos todos pedidos salvos

    final String urlMestre = baseUrl + 'PedidoMestre22';
    final String urlItens = baseUrl + 'PedidoItens';
    Map<int, int> orderStatus = <int, int>{};
    int order = 1;
    await updateVendedor();
    for (var pedido in pedidosSalvos) {
      print(vendedor.pROXIMOPED);
      var bodyMestre = jsonEncode([
        {
          'MBPM': [
            {
              'CLIENTE': pedido['CLIENTE'],
              'COND_PAGTO': pedido['COND_PAGTO'],
              'VENDEDOR': pedido['VENDEDOR'],
              'TEXTO_ESP': pedido['TEXTO_ESP'],
              'DT_PED': pedido['DT_PED'],
              'VLR_PED': pedido['VLR_PED'],
              'CARGA_TOTAL': pedido['CARGA_TOTAL'],
              'NRO_LISTA': pedido['NRO_LISTA'],
              'TIPO_CLI': pedido['TIPO_CLI'],
              'RESERVADO2': pedido['RESERVADO2'],
              'RESERVADO13': pedido['RESERVADO13']
            }
          ],
        },
      ]);

      final responseMestre = await http.post(
        Uri.parse(urlMestre),
        body: bodyMestre,
        headers: {'Content-Type': 'application/json'},
      );

      if (responseMestre.statusCode == 201) {
        List<dynamic> formattedItens = [];

        int sfaNumber = _fetchSFANumber(responseMestre.body);

        print(sfaNumber);

        for (var item in pedido['ITENS_DO_PEDIDO']) {
          formattedItens.add({
            'NUMERO_SFA': sfaNumber,
            'SEQUENCIA': item['SEQUENCIA'],
            'C_PROD_PALM': item['C_PROD_PALM'],
            'QTDE': item['QTDE'],
            'VLR_UNIT': item['VLR_UNIT'],
            'VLR_TOTAL': item['VLR_TOTAL'],
            'DT_ENTREGA': item['DT_ENTREGA'],
            'UNIDADE': item['UNIDADE'],
            'TES': item['TES'],
            'GRUPO': item['GRUPO'],
            'NRO_LISTA': item['NRO_LISTA'],
            'RESERVADO2': item['RESERVADO2'],
            'RESERVADO5': item['RESERVADO5'],
            'RESERVADO13': item['RESERVADO13'],
            'RESERVADO14': item['RESERVADO14'],
            'RESERVADO15': item['RESERVADO15'],
            'RESERVADO16': item['RESERVADO16'],
          });
        }
        var bodyItens = jsonEncode([{'MBPD': formattedItens}]);

        final responseItens = await http.post(
          Uri.parse(urlItens),
          headers: {'Content-Type': 'application/json'},
          body: bodyItens,
        );

        if (responseItens.statusCode != 201) {
          String messageError =
              'Erro nos itens do pedido: $order: Erro #${responseItens.statusCode}';
          print(messageError);
          throw Exception(messageError);
        }

        await updateVendedor();
      }

      orderStatus[order] = responseMestre.statusCode;
      order++;
    }
    if (orderStatus.values.all((status) => status == 201)) {
      print('Update completed');
      clearSavedOrders();
    } else {
      List<String> aux = [];
      print('Post failed');
      orderStatus.removeWhere((key, value) => value == 201);
      orderStatus.forEach((key, value) {
        aux.add('$key (erro $value)');
        print('Order #$key: Problem $value');
      });
      String errors = aux.join(', ');
      throw Exception('Erro nos seguintes pedidos: $errors');
    }
  }

  clearSavedOrders() async {
    //Função para remover todos pedidos salvos
    pedidosSalvos.clear();
    await saveFile();
  }

  _resetData() {
    //Função para zerar todos os dados do provedor
    vendedor = Vendedor();
    clientes = <Cliente>[];
    produtos = <Produto>[];
    grupoPreco = <int, List<ListaPreco>>{};
    listNumber = <int>[];
    cart = <String, CartItem>{};
    pedidosSalvos = [];
    grupos = [Grupos(dESCRICAO: 'TODOS', gRUPO: '')];
  }

  int _fetchSFANumber(String jsonString) {
    var decoded = json.decode(jsonString);
    String sfaNumber = decoded[0]['NUMERO_SFA'];
    return int.parse(sfaNumber);
  }

  _getListaPreco(String id) async {
    //Função para recuperar as listas de preço associadas ao vendedor
    List<ListaPreco> listaDePrecos = [];
    var aux = await _db.getData(_db.getListaPreco, baseUrl, additionalData1: id);
    for (var item in aux) {
      listaDePrecos.add(ListaPreco.fromJson(item));
    }
    grupoPreco = {};
    for (var item in listaDePrecos) {
      int key = item.nROLISTA ?? 0;
      if (grupoPreco.containsKey(key)) {
        grupoPreco[key]!.add(item);
      } else {
        grupoPreco[key] = [item];
      }
    }
    listNumber = grupoPreco.keys.toList()..sort();
  }

  getProdutosEGrupos(String id) async {
    //Função para associar todos os dados concernentes aos produtos
    await getProdutos();
    await _getGrupoProduto();
    await _getGrupos();
    await _getListaPreco(id);
    await _atribuirImagens();
    print("getProdutosEGrupos success");
    notifyListeners();
  }
}
