import 'package:flutter/services.dart';

import 'plugin.dart';

class AppPlugin extends BasePlugin {
  AppPlugin() : super('app');

  @override
  void handlerData(Map<String, dynamic> data) {}

  @override
  void handlerErr(err) {
    print(err);
  }

  /// 安装Apk
  ///
  /// @param filePath apk路径
  ///
  /// @param fileMd5 apk文件的md5值
  void installApk(String filePath, String fileMd5) async {
    assert(filePath.isNotEmpty && fileMd5.isNotEmpty);
    await methodChannel.invokeMethod('installApk', {'filePath': filePath, 'fileMd5': fileMd5});
  }
}
