import 'dart:async';
import 'package:vendasagrindus/model/pedidoMestreFull.dart';
import '../../../data_helper.dart';

class OrderListBloc {
  int _currentMax = 9;
  List<PedidoMestreFull> _allData = List<PedidoMestreFull>();
  List<PedidoMestreFull> shownData = List<PedidoMestreFull>();
  StreamController<List<PedidoMestreFull>> _streamController =
      StreamController();
  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream;

  OrderListBloc(String vendedor) {
    _getAllData(vendedor);
  }

  Future<void> _getAllData(String vendedor) async {
    try {
      return DataHelper().getPedidoMestreFull(vendedor).then((jsonData) {
        for (var item in jsonData) {
          var aux = PedidoMestreFull.fromJson(item);
          if (aux != null) {
            _allData.add(aux);
          }
        }
        shownData.addAll(_allData.getRange(0, 9).toList());
        input.add(shownData);
      });
    } catch (e) {
      print(e);
    }
  }

  addMoreData() {
    _currentMax += 5;
    if (_currentMax + 5 > _allData.length) {
      for (var item
          in _allData.getRange(_currentMax + 1, _allData.length - 1)) {
        shownData.add(item);
      }
    } else {
      for (var item in _allData.getRange(_currentMax + 1, _currentMax + 5)) {
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
