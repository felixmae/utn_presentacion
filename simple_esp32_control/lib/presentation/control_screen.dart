import 'package:flutter/material.dart';
import 'package:simple_esp32_control/domain/set_led_color_use_case.dart';
import 'package:simple_esp32_control/domain/get_number_use_case.dart';
import 'package:simple_esp32_control/domain/set_ip_connection_use_case.dart';

class ControlScreen extends StatelessWidget {
  const ControlScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    SetLedColorUseCase setLedColorUseCase = SetLedColorUseCase();
    GetNumberUseCase getNumberUseCase = GetNumberUseCase();
    SetIpConnectionUseCase setIpConnectionUseCase = SetIpConnectionUseCase();
    int number = 0;

    setIpConnectionUseCase.setIp("192.168.199.179");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Simple Flutter App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => setLedColorUseCase.setColor(200, 0, 0),
              child: const Text("Led Rojo"),
            ),
            ElevatedButton(
              onPressed: () => setLedColorUseCase.setColor(0, 200, 0),
              child: const Text("Led Verde"),
            ),
            ElevatedButton(
              onPressed: () => setLedColorUseCase.setColor(0, 0, 200),
              child: const Text("Led Azul"),
            ),
            ElevatedButton(
              onPressed: () => {number = getNumberUseCase.getNumber()},
              child: const Text("Obtener Numero"),
            ),
          ],
        ),
      ),
    );
  }
}
