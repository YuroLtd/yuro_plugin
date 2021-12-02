import 'dart:async';

import 'plus.dart';

class ConvertPlugin extends Plus {
  @override
  void handlerData(int bid, data) {}

  /// HEIF转为JPG
  ///
  /// + [heifPath] HEIF文件路径
  FutureOr<String?> convertHeif(String heifPath) async {
    if (heifPath.trim().isEmpty) return heifPath;
    if (heifPath.endsWith('.HEIC') || heifPath.endsWith('.heic')) {
      return await methodChannel.invokeMethod('convert/heif', heifPath);
    } else {
      return heifPath;
    }
  }
}
