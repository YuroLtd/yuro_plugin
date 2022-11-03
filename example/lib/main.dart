import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:yuro_plugin/yuro_plugin.dart';

void main() {
  runApp(MaterialApp(theme: ThemeData(useMaterial3: true), home: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  NetworkStatus? networkStatus;

  @override
  void initState() {
    super.initState();
    YuroPlugin.instance.registerNetworkListener(_networkListener);
    networkStatus = YuroPlugin.instance.getNetworkStatus();
  }

  @override
  void dispose() {
    YuroPlugin.instance.unregisterNetworkListener(_networkListener);
    super.dispose();
  }

  void _networkListener(NetworkStatus status) {
    setState(() {
      networkStatus = status;
    });
  }

  void deviceInfo() async{
   final info = await YuroPlugin.instance.deviceInfo();
   debugPrint(info.toJson().toString());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Yuro plugin example')),
      body: Column(children: [
        Text('${networkStatus?.type.desc} || ${networkStatus?.linkAddress.join(' || ') ?? ''}'),
        ElevatedButton(onPressed: deviceInfo, child: const Text('deviceInfo')),
      ]));
}
