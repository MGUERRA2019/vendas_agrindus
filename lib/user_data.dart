import 'package:flutter/foundation.dart';
import 'package:vendasagrindus/data_helper.dart';
import 'package:vendasagrindus/model/clientes.dart';
import 'package:vendasagrindus/model/grupoProdutos.dart';
import 'package:vendasagrindus/model/grupos.dart';
import 'package:vendasagrindus/model/produto.dart';
import 'package:vendasagrindus/model/vendedor.dart';

//Provider class

class UserData extends ChangeNotifier {
  var _db = DataHelper();
  Vendedor vendedor = Vendedor();
  List<Clientes> clientes = List<Clientes>();
  List<Produto> produtos = List<Produto>();
  List<Grupos> grupos = List<Grupos>();

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
    notifyListeners();
  }

  getGrupos() async {
    Iterable listaGr = await _db.getGrupos();
    grupos = listaGr.map((model) => Grupos.fromJson(model)).toList();
    notifyListeners();
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

    notifyListeners();
  }
}
