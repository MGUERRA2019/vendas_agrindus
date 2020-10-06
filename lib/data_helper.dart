import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

//Singleton getClass

const baseUrl =
    "http://189.57.124.26:8081/isapsfa/ISAPServerSFA.dll/datasnap/rest/TSM/";

class DataHelper {
  static final DataHelper _dataHelper = DataHelper._internal();

  factory DataHelper() {
    return _dataHelper;
  }

  DataHelper._internal();

  Future getClientes(String id) async {
    var url = baseUrl + 'GetClientes/' + id;
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(response.statusCode);
    }
  }

  Future getVendedor(String id) async {
    var url = baseUrl + "GetVendedor/" + id;
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(response.statusCode);
    }
  }

  Future getProdutos() async {
    var url = baseUrl + 'GetProdutos';
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(response.statusCode);
    }
  }

  Future getGrupos() async {
    var url = baseUrl + 'GetGrupos';
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(response.statusCode);
    }
  }

  Future getGrupoProdutos() async {
    var url = baseUrl + 'GetGrupoProdutos';
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(response.statusCode);
    }
  }

  Future getCondPagto() async {
    var url = baseUrl + 'GetCondPagto';
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(response.statusCode);
    }
  }

  Future getTipoPagto() async {
    var url = baseUrl + 'GetTipoPagto';
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(response.statusCode);
    }
  }

  Future getListaPreco(String id) async {
    var url = baseUrl + "GetListaPreco/" + id;
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}
