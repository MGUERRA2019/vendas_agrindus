import 'package:flutter/foundation.dart';
import 'package:vendasagrindus/data_helper.dart';
import 'package:vendasagrindus/model/clientes.dart';
import 'package:vendasagrindus/model/vendedor.dart';

//Provider class

class UserData extends ChangeNotifier {
  var _db = DataHelper();
  Vendedor vendedor = Vendedor();
  List<Clientes> clientes = List<Clientes>();

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
}
