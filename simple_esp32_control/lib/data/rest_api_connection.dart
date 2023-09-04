import 'package:flutter/material.dart';
import 'package:rest_api_client/rest_api_client.dart';
import 'dart:developer' as developer;


class RestApiConnection {

  /// the one and only instance of this singleton
  static final RestApiConnection _restApiConnection = RestApiConnection._internal();
  factory RestApiConnection() {
    return _restApiConnection;
  }
  RestApiConnection._internal();

  late IRestApiClient _restApiClient;

  void setIpConnection(String ip)
  {
    if(ip.isNotEmpty){
       _startConnection(ip);
    }
  }


  void _startConnection(String ip) async {

    WidgetsFlutterBinding.ensureInitialized();
    //This must be called once per application lifetime
    await RestApiClient.initFlutter();
    String url ="http://$ip";
    developer.log("Set ip", name: url);
    _restApiClient = RestApiClient(
      options: RestApiClientOptions(
        baseUrl: url,
      ),
    );

    //init must be called, preferably right after the instantiation
    await _restApiClient.init();

    developer.log("Rest API Connection", name: "Init connection .... OK");

    //Use restApiClient from this point on

    //Ignore all exceptions that might happen in the next request
    _restApiClient.exceptionHandler.exceptionOptions.disable();
    // return restApiClient;
  }

  IRestApiClient getConnection() {
    return _restApiClient;
  }

}
