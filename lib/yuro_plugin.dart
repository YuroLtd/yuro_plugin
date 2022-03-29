import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

import 'src/bean/app_info.dart';

export 'src/bean/app_info.dart' show AppInfo;

class YuroPlugin {
  static const MethodChannel _methodChannel = MethodChannel('plugin.yuro.com/method');

// static const EventChannel _eventChannel = EventChannel('plugin.yuro.com/event');

  static YuroPlugin? _yuroPlugin;

  factory YuroPlugin() => _yuroPlugin ??= YuroPlugin._();

  YuroPlugin._();

  /// 获取AppInfo
  Future<AppInfo> appInfo() async {
    final srcJson = await _methodChannel.invokeMethod('app/appInfo');
    return AppInfo.fromJson(Map.from(srcJson!));
  }

  /// 安装Apk(Only Android)
  ///
  /// + [filePath] apk路径
  /// + [fileMd5] apk文件的md5值
  void installApk(String filePath, String fileMd5) async {
    if (Platform.isAndroid) {
      if (filePath.isEmpty || fileMd5.isEmpty) return;
      await _methodChannel.invokeMethod('app/installApk', {'filePath': filePath, 'fileMd5': fileMd5});
    }
  }

  /// HEIF转为JPG
  ///
  /// + [heifPath] HEIF文件路径
  FutureOr<String?> convertHeif(String heifPath) async {
    if (heifPath.trim().isEmpty) return heifPath;
    if (heifPath.endsWith('.HEIC') || heifPath.endsWith('.heic')) {
      return await _methodChannel.invokeMethod('convert/heif', heifPath);
    } else {
      return heifPath;
    }
  }
}
