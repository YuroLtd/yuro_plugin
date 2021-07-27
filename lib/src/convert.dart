import 'dart:async';

import 'plugin.dart';

class ConvertPlugin extends BasePlugin {
  ConvertPlugin() : super('convert');

  @override
  void handlerData(Map<String, dynamic> data) {}

  @override
  void handlerErr(err) {
    print(err);
  }

  /// HEIF转为JPG
  ///
  /// @param heifPath HEIF文件路径
  ///
  /// @param fileMd5 apk文件的md5值
  FutureOr<String?> convertHeif(String heifPath) async {
    assert(heifPath.isNotEmpty);
    if (heifPath.endsWith('.HEIC') || heifPath.endsWith('.heic')) {
      return await methodChannel.invokeMethod('convertHeif', heifPath);
    } else {
      return heifPath;
    }
  }
}
