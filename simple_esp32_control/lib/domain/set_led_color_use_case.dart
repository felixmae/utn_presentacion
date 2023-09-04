import 'package:simple_esp32_control/data/rest_api_connection.dart';
import 'dart:developer' as developer;

class SetLedColorUseCase {
  final _restApiConnection = RestApiConnection();

  void _setLedColor(int red, int green, int blue) async {
    var connection = _restApiConnection.getConnection();

    try {
      connection.post(
        '/led',
        data: {"red": red, "green": green, "blue": blue},
      );
    } catch (e) {
      developer.log("Rest API Connection", name: "Error $e");
    }
  }

  void setColor(int red, int green, int blue) {
    developer.log("Use case", name: "Set color $red, $green, $blue");
    if (red < 0) {
      red = 0;
    }
    if (red > 255) {
      red = 255;
    }

    if (green < 0) {
      green = 0;
    }
    if (green > 255) {
      green = 255;
    }

    if (blue < 0) {
      blue = 0;
    }
    if (blue > 255) {
      blue = 255;
    }
    _setLedColor(red, green, blue);
  }
}
