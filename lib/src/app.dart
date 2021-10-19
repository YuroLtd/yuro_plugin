import 'plugin.dart';

class AppPlugin extends BasePlugin {
  AppPlugin() : super('app');

  /// 安装Apk
  ///
  /// @param filePath apk路径
  ///
  /// @param fileMd5 apk文件的md5值
  void installApk(String filePath, String fileMd5) async {
    if (filePath.isEmpty || fileMd5.isEmpty) return;
    await methodChannel.invokeMethod('installApk', {'filePath': filePath, 'fileMd5': fileMd5});
  }

  /// 获取AndroidId
  Future<String?> androidId() async {
    return await methodChannel.invokeMethod<String>('androidId');
  }
}
