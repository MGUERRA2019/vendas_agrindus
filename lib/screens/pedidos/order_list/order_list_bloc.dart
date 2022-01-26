import 'dart:async';
import 'package:vendasagrindus/model/pedidoMestreFull.dart';
import '../../../data_helper.dart';

//BLoC utilizado para recuperar e controlar dados visualizados pelo usuário na tela de pedidos do vendedor

class OrderListBloc {
  int _currentMax = 9;
  int _moreValue = 5;
  List<PedidoMestreFull> _allData = List<PedidoMestreFull>();
  List<PedidoMestreFull> shownData = List<PedidoMestreFull>();
  StreamController<List<PedidoMestreFull>> _streamController =
      StreamController();
  bool hasMore = true;
  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream;
  DataHelper _db = DataHelper();

  OrderListBloc(String vendedor, String baseUrl) {
    _getAllData(vendedor, baseUrl);
  }

  Future<void> _getAllData(String vendedor, String baseUrl) async {
    try {
      return _db
          .getData(_db.getPedidoMestreFull, baseUrl, additionalData1: vendedor)
          .then((jsonData) {
        try {
          for (var item in jsonData) {
            var aux = PedidoMestreFull.fromJson(item);
            if (aux != null) {
              _allData.add(aux);
            }
          }
          if (_allData != null) {
            if (_allData.length < 9) {
              hasMore = false;
              shownData.addAll(_allData);
            } else {
              shownData.addAll(_allData.getRange(0, 9).toList());
            }
          }
          input.add(shownData);
        } catch (e) {
          print(e);
          input.add(shownData);
        }
      });
    } catch (e) {
      print(e);
      input.add(shownData);
    }
  }

  cancelQuery() {
    _currentMax = 9;
    hasMore = true;
    shownData = List<PedidoMestreFull>();
    if (_allData != null) {
      if (_allData.length < 9) {
        hasMore = false;
        shownData.addAll(_allData);
      } else {
        shownData.addAll(_allData.getRange(0, 9).toList());
      }
    }
    input.add(shownData);
  }

  queryDatabyDate(DateTime date) {
    shownData = List<PedidoMestreFull>();
    for (var item in _allData) {
      if (item.dTPED == date) {
        shownData.add(item);
      }
    }
    hasMore = false;
    input.add(shownData);
  }

  addMoreData() {
    if (_currentMax + _moreValue > _allData.length) {
      hasMore = false;
      for (var item
          in _allData.getRange(_currentMax + 1, _allData.length - 1)) {
        shownData.add(item);
      }
    } else {
      for (var item in _allData.getRange(_currentMax, _currentMax + _moreValue).toList()) {
        shownData.add(item);
      }
      _currentMax += 5;
    }
    input.add(shownData);
  }

  dispose() {
    _streamController.close();
  }
}
