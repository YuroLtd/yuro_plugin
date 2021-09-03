import 'dart:async';

import 'plugin.dart';

class ConvertPlugin extends BasePlugin {
  ConvertPlugin() : super('convert');

  /// HEIF转为JPG
  ///
  /// @param heifPath HEIF文件路径
  FutureOr<String?> convertHeif(String heifPath) async {
    assert(heifPath.isNotEmpty);
    if (heifPath.endsWith('.HEIC') || heifPath.endsWith('.heic')) {
      return await methodChannel.invokeMethod('convertHeif', heifPath);
    } else {
      return heifPath;
    }
  }
}
