import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

//Singleton getClass

const baseUrl =
    "http://189.57.124.26:8081/isapsfa/ISAPServerSFA.dll/datasnap/rest/TSM/";

class DataHelper {
  static final DataHelper _dataHelper = DataHelper._internal();
  static final brNumber = NumberFormat('###0.00', 'pt_BR');
  static final format = DateFormat.yMd('pt_BR');

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

  Future getImagemPreco() async {
    var url = baseUrl + 'GetProdutosImagem';
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(response.statusCode);
    }
  }

  Future getPedidoMestre(String codCliente) async {
    var url = baseUrl + 'GetPedidoMestre/' + codCliente;
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(response.statusCode);
    }
  }

  Future getPedidoItem(String numPedido) async {
    var url = baseUrl + 'GetPedidoItens/' + numPedido;
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(response.statusCode);
    }
  }

  static DateTime toDateTime(String date) {
    String month;
    List<String> splittedDate = date.split(' ');
    String day;
    switch (splittedDate[0]) {
      case "Jan":
        month = '01';
        break;
      case "Feb":
        month = '02';
        break;
      case "Mar":
        month = '03';
        break;
      case "Apr":
        month = '04';
        break;
      case "May":
        month = '05';
        break;
      case "Jun":
        month = '06';
        break;
      case "Jul":
        month = '07';
        break;
      case "Aug":
        month = '08';
        break;
      case "Sep":
        month = '09';
        break;
      case "Oct":
        month = '10';
        break;
      case "Nov":
        month = '11';
        break;
      case "Dez":
        month = '12';
        break;
    }
    day = splittedDate[2];

    if (splittedDate[2].length == 1) {
      day = '0${splittedDate[2]}';
    }
    String formattedDate = splittedDate[3] + month + day;
    return DateTime.tryParse(formattedDate);
  }
}
