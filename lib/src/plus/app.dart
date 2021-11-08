import 'dart:io';

import 'package:yuro_plugin/yuro_plugin.dart';

import 'plus.dart';

class AppPlugin extends Plus {
  @override
  void handlerData(int bid, data) {}

  /// 安装Apk
  ///
  /// + [filePath] apk路径
  /// + [fileMd5] apk文件的md5值
  void installApk(String filePath, String fileMd5) async {
    if (filePath.isEmpty || fileMd5.isEmpty) return;
    await YuroPlugin.methodChannel.invokeMethod('app/installApk', {'filePath': filePath, 'fileMd5': fileMd5});
  }

  /// 获取AndroidId
  Future<String?> androidId() async {
    return await YuroPlugin.methodChannel.invokeMethod<String>('app/androidId');
  }

  /// 获取userAgent
  Future<String?> userAgent() async {
    final agentStr = await YuroPlugin.methodChannel.invokeMethod<String>('app/userAgent');
    return agentStr ?? HttpClient().userAgent;
  }
}
