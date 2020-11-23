import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
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
import 'package:vendasagrindus/model/produto.dart';
import 'package:vendasagrindus/model/produtosImagem.dart';
import 'package:vendasagrindus/model/tipoMovimento.dart';
import 'package:vendasagrindus/model/vendedor.dart';
import 'package:darq/darq.dart';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;

//Provider class

class UserData extends ChangeNotifier {
  var _db = DataHelper();
  Vendedor vendedor = Vendedor();
  List<Cliente> clientes = List<Cliente>();
  List<Produto> produtos = List<Produto>();
  Map<int, List<ListaPreco>> grupoPreco = Map<int, List<ListaPreco>>();
  List<int> listNumber = List<int>();
  Map<String, CartItem> cart = Map<String, CartItem>();
  List<PedidoMestre> pedidosMestre = List<PedidoMestre>();
  List<dynamic> pedidosSalvos = [];
  List<Grupos> grupos = [
    Grupos(
      dESCRICAO: 'TODOS',
      gRUPO: '',
    ),
  ];

  getVendedor(String id) async {
    var dadosVendedor = await _db.getVendedor(id);
    vendedor = Vendedor.fromJson(dadosVendedor[0]);
    notifyListeners();
  }

  getClientes() async {
    Iterable listaClientes = await _db.getClientes(vendedor.vENDEDOR);
    clientes = listaClientes.map((model) => Cliente.fromJson(model)).toList();
    await _getTipoMovimento();
    await _getCondPagto();
    notifyListeners();
  }

  Cliente getClienteFromPedidosSalvos(int index) {
    String cliente = pedidosSalvos[index]['CLIENTE'];
    return clientes.singleWhere((element) => element.cLIENTE == cliente);
  }

  getProdutos() async {
    Iterable listaProdutos = await _db.getProdutos();
    produtos = listaProdutos.map((model) => Produto.fromJson(model)).toList();
  }

  _getGrupoProduto() async {
    List<GrupoProdutos> grupoProdutos = List<GrupoProdutos>();
    var listaGP = await _db.getGrupoProdutos();
    for (var item in listaGP) {
      grupoProdutos.add(GrupoProdutos.fromJson(item));
    }

    for (var produto in produtos) {
      var element = grupoProdutos
          .singleWhere((element) => (element.cPRODPALM == produto.cPRODPALM));
      if (element != null) {
        produto.gRUPO = element.gRUPO;
      } else {
        print('Merge error');
      }
    }
  }

  _getGrupos() async {
    Iterable listaGr = await _db.getGrupos();
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
    for (var item in grupoPreco[key]) {
      for (var produto in produtos) {
        if (produto.cPRODPALM == item.cPRODPALM) {
          produto.pRECO = item.pRECO;
        }
      }
    }
  }

  removerQtde(Produto produto) {
    if (cart.containsKey(produto.cPRODPALM)) {
      if (cart[produto.cPRODPALM].amount > 0) {
        cart[produto.cPRODPALM].amount--;
      }
      if (cart[produto.cPRODPALM].amount == 0) {
        cart.remove(produto.cPRODPALM);
      }
      notifyListeners();
    }
  }

  addCartItem(Produto produto) {
    if (cart.containsKey(produto.cPRODPALM)) {
      cart[produto.cPRODPALM].amount += 1;
    } else {
      cart.putIfAbsent(
          produto.cPRODPALM,
          () => CartItem(
                price: produto.pRECO,
                name: produto.dESCRICAO,
                barCode: produto.cODBARRA,
                image: produto.iMAGEMURL,
                code: produto.cPRODPALM,
                weight: produto.pESOBRUTO,
              ));
    }

    notifyListeners();
  }

  getCart(List<CartItem> items) {
    for (var item in items) {
      cart[item.code] = item;
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
    List<ProdutoImagem> imageList = List<ProdutoImagem>();
    var aux = await _db.getImagemPreco();
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

  _getListaPreco(String id) async {
    List<ListaPreco> precos = List<ListaPreco>();
    var listaPreco = await _db.getListaPreco(id);
    for (var item in listaPreco) {
      precos.add(ListaPreco.fromJson(item));
    }

    grupoPreco = groupBy(precos, (p) => p.nROLISTA);

    listNumber = precos
        .select((element, index) => element.nROLISTA)
        .distinct((element) => element)
        .orderBy((element) => element)
        .toList();
  }

  _getTipoMovimento() async {
    List<TipoMovimento> listaMovimentos = List<TipoMovimento>();
    Iterable aux = await _db.getTipoMovimento();
    listaMovimentos =
        aux.map((model) => TipoMovimento.fromJson(model)).toList();
    for (var item in listaMovimentos) {
      for (var cliente in clientes) {
        if (cliente.tIPOCLI == item.tIPOCLI) {
          cliente.tIPOMOVIMENTO = item;
        }
      }
    }
  }

  _getCondPagto() async {
    List<CondPagto> listaCondPagtos = List<CondPagto>();
    Iterable aux = await _db.getCondPagto();
    listaCondPagtos = aux.map((model) => CondPagto.fromJson(model)).toList();
    for (var item in listaCondPagtos) {
      for (var cliente in clientes) {
        if (cliente.cONDPAGTO == item.cONDPAGTO) {
          cliente.cONDPAGTOobj = item;
        }
      }
    }
  }

  void getPedidoMestre(String codCliente) async {
    Iterable aux = await _db.getPedidoMestre(codCliente);
    try {
      pedidosMestre = aux.map((model) => PedidoMestre.fromJson(model)).toList();
      notifyListeners();
    } catch (e) {
      pedidosMestre.clear();
      print(e);
    }
  }

  Future<List<PedidoItem>> getPedidoItem(String numeroDoPedido) async {
    Iterable aux = await _db.getPedidoItem(numeroDoPedido);
    return aux.map((model) => PedidoItem.fromJson(model)).toList();
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/orders.json");
  }

  saveFile() async {
    var file = await _getFile();
    String data = json.encode(pedidosSalvos);
    file.writeAsString(data);
  }

  saveOrder(PedidoMestre newOrder) async {
    var item = newOrder.toJson();
    pedidosSalvos.add(item);
    saveFile();
    notifyListeners();
  }

  getOrders() async {
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
    pedidosSalvos.removeAt(index);
    saveFile();
    notifyListeners();
  }

  sendAllOrders() async {
    final String url = baseUrl + 'UpdatePedidoMestre/';
    Map<int, int> orderStatus = Map<int, int>();
    int order = 1;
    for (var pedido in pedidosSalvos) {
      final response = await http.post(
        url,
        body: {
          'MBPM': {
            'NUMERO_SFA': vendedor.pROXIMOPED,
            'CLIENTE': pedido['CLIENTE'],
            'COND_PAGTO': pedido['COND_PAGTO'],
            'VENDEDOR': pedido['VENDEDOR'],
            'TEXTO_ESP': pedido['TEXTO_ESP'],
            'DT_PED': pedido['DT_PED'],
            'NRO_LISTA': pedido['NRO_LISTA'],
            'TIPO_CLI': pedido['TIPO_CLI'],
            'RESERVADO2': '0',
            'RESERVADO8': '0',
          }
        },
      );
      orderStatus[order] = response.statusCode;
      order++;
    }
    if (orderStatus.values.all((status) => status == 201)) {
      print('Update completed');
      pedidosSalvos.clear();
      saveFile();
    } else {
      List<String> aux = [];
      print('Post failed');
      orderStatus.removeWhere((key, value) => value == 201);
      orderStatus.forEach((key, value) {
        aux.add('$key (erro $value)');
        print('Order #$key: Problem $value');
      });
      String errors = aux.join(', ');
      throw new Exception('Erro nos seguintes pedidos: $errors');
    }
  }

  getProdutosEGrupos(String id) async {
    await getProdutos();
    await _getGrupoProduto();
    await _getGrupos();
    await _getListaPreco(id);
    await _atribuirImagens();
    notifyListeners();
  }
}
