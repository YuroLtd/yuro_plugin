// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppInfo _$AppInfoFromJson(Map<String, dynamic> json) {
  return AppInfo(
    json['appName'] as String,
    json['packageName'] as String,
    json['versionName'] as String,
    json['versionCode'] as int,
    json['androidId'] as String?,
    json['userAgent'] as String,
  );
}

Map<String, dynamic> _$AppInfoToJson(AppInfo instance) => <String, dynamic>{
      'appName': instance.appName,
      'packageName': instance.packageName,
      'versionName': instance.versionName,
      'versionCode': instance.versionCode,
      'androidId': instance.androidId,
      'userAgent': instance.userAgent,
    };
