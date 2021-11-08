import 'dart:async';

import 'package:yuro_plugin/yuro_plugin.dart';
import 'package:yuro_plugin/src/util/string.dart';

import 'plus.dart';

class ConvertPlugin extends Plus {
  @override
  void handlerData(int bid, data) {}

  /// HEIF转为JPG
  ///
  /// + [heifPath] HEIF文件路径
  FutureOr<String?> convertHeif(String heifPath) async {
    if (heifPath.isNullOrBlank()) return heifPath;
    if (heifPath.endsWith('.HEIC') || heifPath.endsWith('.heic')) {
      return await YuroPlugin.methodChannel.invokeMethod('convert/heif', heifPath);
    } else {
      return heifPath;
    }
  }
}
