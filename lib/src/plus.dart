import 'package:flutter/services.dart';

const _METHOD_CHANNEL = 'plugin.yuro.com/method';
const _EVENT_CHANNEL = 'plugin.yuro.com/event';

const MethodChannel methodChannel = MethodChannel(_METHOD_CHANNEL);
const EventChannel eventChannel = EventChannel(_EVENT_CHANNEL);

abstract class Plus {
  void handlerData(int bid, dynamic data);
}
