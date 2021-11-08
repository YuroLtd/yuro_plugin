import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yuro_plugin/src/plus/app.dart';
import 'package:yuro_plugin/src/plus/convert.dart';

import 'src/bean/bean.dart';
import 'src/plus/plus.dart';
import 'src/util/map_ext.dart';

export 'src/bean/bean.dart' show AppInfo;

class YuroPlugin {
  static const _METHOD_CHANNEL = 'plugin.yuro.com/method';
  static const _EVENT_CHANNEL = 'plugin.yuro.com/event';

  static const MethodChannel methodChannel = const MethodChannel(_METHOD_CHANNEL);
  static const EventChannel _eventChannel = const EventChannel(_EVENT_CHANNEL);

  static YuroPlugin? _yuroPlugin;
  static Map<Tid, Plus> _plugMap = {};

  YuroPlugin._() {
    _eventChannel
        .receiveBroadcastStream()
        .asBroadcastStream()
        .map<Map<String, dynamic>>((event) => Map<String, dynamic>.from(event))
        .listen(_onData, onError: _onError);
  }

  factory YuroPlugin() => _yuroPlugin ??= YuroPlugin._();

  void _onData(Map<String, dynamic> event) {
    final eventSink = EventSink.fromJson(event);
    _plugMap.where((k, v) => k == eventSink.tid).forEach((key, value) {
      value.handlerData(eventSink.bid, eventSink.data);
    });
  }

  void _onError(err) => debugPrint(err);

  AppPlugin get app => _plugMap.putIfAbsent(Tid.APP, () => AppPlugin()) as AppPlugin;

  ConvertPlugin get convert => _plugMap.putIfAbsent(Tid.CONVERT, () => ConvertPlugin()) as ConvertPlugin;
}
