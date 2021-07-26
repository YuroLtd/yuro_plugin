import 'package:flutter/services.dart';

const MethodChannel methodChannel = const MethodChannel('plugin.yuro.com/method');
const EventChannel eventChannel = const EventChannel('plugin.yuro.com/event');

abstract class BasePlugin {
  void handlerData(Map<String, dynamic> data);

  void handlerErr(err);

  BasePlugin(String type) {
    eventChannel
        .receiveBroadcastStream()
        .asBroadcastStream()
        .map((event) => Map<String, dynamic>.from(event)..deepCast())
        .where((event) => event['type'] == type)
        .listen((data) => handlerData(Map<String, dynamic>.from(data['data'])), onError: handlerErr);
  }
}

extension _MapExt on Map {
  void deepCast() {
    keys.forEach((key) {
      if (this[key] is Map) {
        this[key] = Map<String, dynamic>.from(this[key])..deepCast();
      }
      if (this[key] is List) {
        var list = this[key] as List;
        this[key] = List.generate(list.length, (index) => Map<String, dynamic>.from(list[index])..deepCast());
      }
    });
  }
}
