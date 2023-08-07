// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceInfo _$DeviceInfoFromJson(Map<String, dynamic> json) => DeviceInfo(
      android: json['android'] == null
          ? null
          : AndroidInfo.fromJson(json['android'] as Map<String, dynamic>),
      ios: json['ios'] == null
          ? null
          : IosInfo.fromJson(json['ios'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DeviceInfoToJson(DeviceInfo instance) =>
    <String, dynamic>{
      'android': instance.android?.toJson(),
      'ios': instance.ios?.toJson(),
    };

IosInfo _$IosInfoFromJson(Map<String, dynamic> json) => IosInfo(
      json['brand'] as String,
      json['model'] as String,
      json['sdk'] as String,
      json['userAgent'] as String?,
      json['userAgent2'] as String,
      json['packageName'] as String,
      json['udid'] as String,
    );

Map<String, dynamic> _$IosInfoToJson(IosInfo instance) => <String, dynamic>{
      'brand': instance.brand,
      'model': instance.model,
      'sdk': instance.sdk,
      'userAgent': instance.userAgent,
      'userAgent2': instance.userAgent2,
      'packageName': instance.packageName,
      'udid': instance.udid,
    };

AndroidInfo _$AndroidInfoFromJson(Map<String, dynamic> json) => AndroidInfo(
      json['brand'] as String,
      json['model'] as String,
      json['sdk'] as String,
      json['abis'] as String,
      json['userAgent'] as String,
      json['userAgent2'] as String,
      json['packageName'] as String,
      json['androidId'] as String,
      json['isRoot'] as bool,
    );

Map<String, dynamic> _$AndroidInfoToJson(AndroidInfo instance) =>
    <String, dynamic>{
      'brand': instance.brand,
      'model': instance.model,
      'sdk': instance.sdk,
      'abis': instance.abis,
      'userAgent': instance.userAgent,
      'userAgent2': instance.userAgent2,
      'packageName': instance.packageName,
      'androidId': instance.androidId,
      'isRoot': instance.isRoot,
    };
