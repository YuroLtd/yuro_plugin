import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:yuro_plugin/yuro_plugin.dart';

class YuroPluginPlatformAndroid extends YuroPlugin {
  static void registerWith() {
    YuroPlugin.instance = YuroPluginPlatformAndroid._();
  }

  YuroPluginPlatformAndroid._() {
    methodChannel.setMethodCallHandler(_methodCall);
  }

  @visibleForTesting
  final methodChannel = const MethodChannel('com.yuro.plugin/android');

  Future<dynamic> _methodCall(MethodCall call) async {}

  @override
  void installApk(String filePath) async {
    await methodChannel.invokeMethod('system/installApk', filePath);
  }

  @override
  Future<String?> recordLog() async => await methodChannel.invokeMethod('system/recordLog');

  @override
  Future<String?> getFileMd5(String filePath) async {
    return await methodChannel.invokeMethod('util/getFileMd5', filePath);
  }

  @override
  Future<DeviceInfo> deviceInfo() async {
    final result = await methodChannel.invokeMethod('system/deviceInfo');
    final deviceInfo = DeviceInfo();
    if (result != null) deviceInfo.android = AndroidInfo.fromJson(Map<String, dynamic>.from(result));
    return deviceInfo;
  }
}
