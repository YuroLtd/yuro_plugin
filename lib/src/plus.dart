import 'package:flutter/services.dart';

const MethodChannel methodChannel = MethodChannel('plugin.yuro.com/method');
const EventChannel eventChannel = EventChannel('plugin.yuro.com/event');

abstract class Plus {
  void handlerData(int bid, dynamic data);
}
