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
  final methodChannel = const MethodChannel('plugins.yuro.com/yuro_android');
  NetworkStatus? _networkStatus;
  final _networkStatusListeners = <NetworkStatusListener>[];

  Future<dynamic> _methodCall(MethodCall call) async {
    switch (call.method) {
      case 'networkStatus':
        final status = NetworkStatus.fromJson(Map<String, dynamic>.from(call.arguments));
        if (_networkStatus == status) return;
        void forEach(NetworkStatusListener listener) => listener.call(status);
        _networkStatusListeners.forEach(forEach);
        _networkStatus = status;
        break;
      default:
        break;
    }
  }

  @override
  void installApk(String filePath) async {
    await methodChannel.invokeMethod('system/installApk', filePath);
  }

  @override
  Future<DeviceInfo> deviceInfo() async {
    final result = await methodChannel.invokeMethod('system/deviceInfo');
    final deviceInfo = DeviceInfo();
    if (result != null) deviceInfo.android = DeviceInfoAndroid.fromJson(Map<String, dynamic>.from(result));
    return deviceInfo;
  }

  @override
  void registerNetworkListener(NetworkStatusListener listener) => _networkStatusListeners.add(listener);

  @override
  void unregisterNetworkListener(NetworkStatusListener listener) => _networkStatusListeners.remove(listener);

  @override
  NetworkStatus? getNetworkStatus() => _networkStatus;

  @override
  Future<String?> recordLog() async => await methodChannel.invokeMethod('system/recordLog');
}
