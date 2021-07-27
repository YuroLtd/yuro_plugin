#import "YuroPlugin.h"
#if __has_include(<yuro_plugin/yuro_plugin-Swift.h>)
#import <yuro_plugin/yuro_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "yuro_plugin-Swift.h"
#endif

@implementation YuroPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftYuroPlugin registerWithRegistrar:registrar];
}
@end
