import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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

//Provider class

class UserData extends ChangeNotifier {
  var _db = DataHelper();
  Vendedor vendedor = Vendedor();
  List<Cliente> clientes = List<Cliente>();
  List<Produto> produtos = List<Produto>();
  Map<int, List<ListaPreco>> grupoPreco = Map<int, List<ListaPreco>>();
  List<int> listNumber = List<int>();
  List<CartItem> cartItems = List<CartItem>();
  List<PedidoMestre> pedidosMestre = List<PedidoMestre>();
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

  adicionarQtde(CartItem cartItem) {
    cartItem.amount++;
    notifyListeners();
  }

  removerQtde(CartItem cartItem) {
    if (cartItem.amount > 0) {
      cartItem.amount--;
    }
    notifyListeners();
  }

  addItem(Produto produto) {
    cartItems.add(CartItem(
      price: produto.pRECO,
      name: produto.dESCRICAO,
      barCode: produto.cODBARRA,
      image: produto.iMAGEMURL,
      code: produto.cPRODPALM,
      weight: produto.pESOBRUTO,
    ));
  }

  double getTotal() {
    double sum = 0.0;
    for (var item in cartItems) {
      sum += item.total;
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

  getProdutosEGrupos(String id) async {
    await getProdutos();
    await _getGrupoProduto();
    await _getGrupos();
    await _getListaPreco(id);
    await _atribuirImagens();
    notifyListeners();
  }
}
