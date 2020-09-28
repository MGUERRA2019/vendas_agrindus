
import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "http://189.57.124.26:8081/isapsfa/ISAPServerSFA.dll/datasnap/rest/TSM/";

class API {

  static Future getClientes() async{
     var url = baseUrl + "GetClientes/100";
     return await http.get(url);  
  }
  
}