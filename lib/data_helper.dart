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
  static final String _permissionPassword = "!Master3270";

//Todas chamadas get são definidas por Strings que serão usadas no Provider

  final getVendedor = 'GetVendedor/';
  final getClientes = 'GetClientes/';
  final getProdutos = 'GetProdutos';
  final getGrupos = 'GetGrupos';
  final getGrupoProdutos = 'GetGrupoProdutos';
  final getCondPagto = 'GetCondPagto';
  final getTipoPagto = 'GetTipoPagto';
  final getTipoMovimento = 'GetTipoMovimento';
  final getListaPreco = 'GetListaPreco/';
  final getProdutosImagem = 'GetProdutosImagem';
  final getPedidoMestre = 'GetPedidoMestre/';
  final getPedidoMestreFull = 'GetPedidoMestreFull/';
  final getPedidoItem = 'GetPedidoItens/';

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

  String get permissionPassword {
    return _permissionPassword;
  }

  static DateTime toDateTime(String date) {
    //Função para intepretar a data dada pelo banco de dados (status: incompleta)
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
