import 'package:yuro_plugin/src/bean/bean.dart';
import 'package:yuro_plugin/yuro_plugin.dart';

import 'plus.dart';

class AppPlugin extends Plus {
  @override
  void handlerData(int bid, data) {}

  /// 获取AppInfo
  Future<AppInfo> appInfo() async {
    final srcJson = await methodChannel.invokeMethod('app/appInfo');
    return AppInfo.fromJson(Map.from(srcJson!));
  }

  /// 安装Apk
  ///
  /// + [filePath] apk路径
  /// + [fileMd5] apk文件的md5值
  void installApk(String filePath, String fileMd5) async {
    if (filePath.isEmpty || fileMd5.isEmpty) return;
    await methodChannel.invokeMethod('app/installApk', {'filePath': filePath, 'fileMd5': fileMd5});
  }
}
