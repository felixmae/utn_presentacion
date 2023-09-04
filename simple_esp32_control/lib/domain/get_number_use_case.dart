import 'package:simple_esp32_control/data/rest_api_connection.dart';
import 'dart:developer' as developer;

class GetNumberUseCase {
  final _restApiConnection = RestApiConnection();
  
  int number = 0;
    
  void _getNumber() async {
    var connection = _restApiConnection.getConnection();

    try {
      final response = await connection.get('/number');
      if (response.isSuccess) {
        number = response.data['number'] as int;
      }
    } catch (e) {
      developer.log("Rest API Connection", name: "Error $e");
    }
  }

  int getNumber() {
    _getNumber();
    developer.log("Use case", name: '$number');
    return number;
  }

}