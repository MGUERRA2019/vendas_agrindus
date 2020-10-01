import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
    return await http.get(url);
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
}
