import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

main() {

  int _fetchSFANumber(String jsonString) {
    var decoded = json.decode(jsonString);
    String sfaNumber = decoded[0]['NUMERO_SFA'];
    return int.parse(sfaNumber);
  }
  
  test('Should return an integer when receives a json string', () {

    String jsonString = '[{"NUMERO_SFA":"30124557"}]';
    int sfaNumber = _fetchSFANumber(jsonString);

    expect(sfaNumber, 30124557);

  });
  
}