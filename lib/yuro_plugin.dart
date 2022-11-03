import 'dart:io';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:yuro_plugin/src/yuro_plugin_platform_android.dart';

import 'src/bean/device_info.dart';
import 'src/bean/network_status.dart';
import 'src/util/exception.dart';

export 'src/bean/device_info.dart';
export 'src/bean/network_status.dart';


abstract class YuroPlugin extends PlatformInterface {
  static final Object _token = Object();

  static YuroPlugin? _instance;

  static YuroPlugin get instance {
    if (_instance == null) {
      if (Platform.isAndroid) {
        YuroPluginPlatformAndroid.registerWith();
        // } else if (Platform.isIOS) {
        // } else if (Platform.isWindows) {
        // } else if (Platform.isMacOS) {
        // } else if (Platform.isLinux) {
        // } else if (Platform.isFuchsia) {
      } else {
        throw UnsupportedError('Plugin is no supported on ${Platform.operatingSystem}');
      }
    }
    return _instance!;
  }

  static set instance(YuroPlugin instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  YuroPlugin() : super(token: _token);

  /// 安装Apk(Only Android)
  void installApk(String filePath) {
    throw UnsupportedError('installApk() is no supported on ${Platform.operatingSystem}');
  }

  /// 获取设备信息
  Future<DeviceInfo> deviceInfo() {
    throw MissingPluginImplementException(Platform.operatingSystem);
  }

  /// 获取当前网络状态
  NetworkStatus? getNetworkStatus() {
    throw MissingPluginImplementException(Platform.operatingSystem);
  }

  /// 注册网络状态监听
  void registerNetworkListener(NetworkStatusListener listener) {
    throw MissingPluginImplementException(Platform.operatingSystem);
  }

  /// 注销网络状态监听
  void unregisterNetworkListener(NetworkStatusListener listener) {
    throw MissingPluginImplementException(Platform.operatingSystem);
  }
}
