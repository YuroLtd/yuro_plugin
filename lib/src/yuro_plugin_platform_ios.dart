import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:yuro_plugin/yuro_plugin.dart';

class YuroPluginPlatformIos extends YuroPlugin {
  static void registerWith() {
    YuroPlugin.instance = YuroPluginPlatformIos._();
  }

  YuroPluginPlatformIos._() {
    methodChannel.setMethodCallHandler(_methodCall);
  }

  @visibleForTesting
  final methodChannel = const MethodChannel('com.yuro.plugin/ios');

  Future<dynamic> _methodCall(MethodCall call) async {
    
  }

  @override
  Future<DeviceInfo> deviceInfo() async {
    final result = await methodChannel.invokeMethod('system/deviceInfo');
    print(result);
    final deviceInfo = DeviceInfo();
    if (result != null) deviceInfo.ios = IosInfo.fromJson(Map<String, dynamic>.from(result));
    return deviceInfo;
  }
}
