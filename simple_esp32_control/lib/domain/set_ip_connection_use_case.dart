import 'package:simple_esp32_control/data/rest_api_connection.dart';

class SetIpConnectionUseCase {
  final _restApiConnection = RestApiConnection();

  void setIp(String ip) {
    if (ip.isNotEmpty) {
      _restApiConnection.setIpConnection(ip);
    }
  }
}
