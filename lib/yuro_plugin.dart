import 'dart:io';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'src/bean/device_info.dart';
import 'src/util/exception.dart';

import 'src/yuro_plugin_platform_android.dart';
import 'src/yuro_plugin_platform_ios.dart';

export 'src/bean/device_info.dart';

abstract class YuroPlugin extends PlatformInterface {
  static final Object _token = Object();

  static YuroPlugin? _instance;

  static YuroPlugin get instance {
    if (_instance == null) {
      if (Platform.isAndroid) {
        YuroPluginPlatformAndroid.registerWith();
      } else if (Platform.isIOS) {
        YuroPluginPlatformIos.registerWith();
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

  /// 记录应用日志(Only Android), 返回日志保存路径
  Future<String?> recordLog() {
    throw MissingPluginImplementException(Platform.operatingSystem);
  }

  /// 获取文件的md5
  Future<String?> getFileMd5(String filePath) async {
    throw MissingPluginImplementException(Platform.operatingSystem);
  }

  /// 获取设备信息
  Future<DeviceInfo> deviceInfo() {
    throw MissingPluginImplementException(Platform.operatingSystem);
  }
}
