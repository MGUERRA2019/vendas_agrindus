import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

//Singleton getClass

class DataHelper {
  static final DataHelper _dataHelper = DataHelper._internal();
  static final brNumber = NumberFormat('###0.00', 'pt_BR');
  static final format = DateFormat.yMd('pt_BR');

//Todas chamadas get são definidas por Strings que serão usadas no Provider

  factory DataHelper() {
    return _dataHelper;
  }

  DataHelper._internal();

  Future getData(String call, String baseUrl,
      {String additionalData1 = '', String additionalData2 = ''}) async {
    //Função genérica get que recebe uma das Strings get, o base url
    //e dados adicionais dependendo da chamada get (número do vendedor, código do cliente, etc.)
    try {
      if (additionalData2 != '') {
        additionalData2 = '/' + additionalData2;
      }
      var url = baseUrl + call + additionalData1 + additionalData2;
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print(call);
        print(response.statusCode);
      }
    } catch (e) {
      throw new Exception('Erro no servidor. Tente mais tarde');
    }
  }

  static noDataSnackbar(BuildContext context) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Funcionalidade não disponível no momento'),
        duration: Duration(milliseconds: 1500),
      ),
    );
  }
}
