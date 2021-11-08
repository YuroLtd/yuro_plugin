import 'package:json_annotation/json_annotation.dart';

part 'app_info.g.dart';

@JsonSerializable()
class AppInfo extends Object {
  @JsonKey(name: 'appName')
  String appName;

  @JsonKey(name: 'packageName')
  String packageName;

  @JsonKey(name: 'versionName')
  String versionName;

  @JsonKey(name: 'versionCode')
  int versionCode;

  @JsonKey(name: 'androidId')
  String? androidId;

  @JsonKey(name: 'userAgent')
  String userAgent;

  AppInfo(
    this.appName,
    this.packageName,
    this.versionName,
    this.versionCode,
    this.androidId,
    this.userAgent,
  );

  factory AppInfo.fromJson(Map<String, dynamic> srcJson) => _$AppInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AppInfoToJson(this);
}
