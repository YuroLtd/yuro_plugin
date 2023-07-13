import Flutter
import UIKit

public class YuroPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "com.yuro.plugin/ios", binaryMessenger: registrar.messenger())
    let instance = YuroPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "system/deviceInfo":
      SystemKit.instance.deviceInfo(result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
