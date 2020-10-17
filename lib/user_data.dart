import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:vendasagrindus/data_helper.dart';
import 'package:vendasagrindus/model/clientes.dart';
import 'package:vendasagrindus/model/grupoProdutos.dart';
import 'package:vendasagrindus/model/grupos.dart';
import 'package:vendasagrindus/model/listaPreco.dart';
import 'package:vendasagrindus/model/produto.dart';
import 'package:vendasagrindus/model/vendedor.dart';
import 'package:darq/darq.dart';
import 'package:collection/collection.dart';

//Provider class

class UserData extends ChangeNotifier {
  var _db = DataHelper();
  Vendedor vendedor = Vendedor();
  List<Clientes> clientes = List<Clientes>();
  List<Produto> produtos = List<Produto>();
  Map<int, List<ListaPreco>> grupoPreco = Map<int, List<ListaPreco>>();
  List<int> listNumber = List<int>();
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
    clientes = listaClientes.map((model) => Clientes.fromJson(model)).toList();
    notifyListeners();
  }

  getProdutos() async {
    Iterable listaProdutos = await _db.getProdutos();
    produtos = listaProdutos.map((model) => Produto.fromJson(model)).toList();
  }

  getGrupoProduto() async {
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

  getGrupos() async {
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

  getListaPreco(String id) async {
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

  getProdutosEGrupos(String id) async {
    await getProdutos();
    await getGrupoProduto();
    await getGrupos();
    await getListaPreco(id);
    notifyListeners();
  }
}
