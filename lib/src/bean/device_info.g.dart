// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceInfo _$DeviceInfoFromJson(Map<String, dynamic> json) => DeviceInfo(
      android: json['android'] == null
          ? null
          : DeviceInfoAndroid.fromJson(json['android'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DeviceInfoToJson(DeviceInfo instance) =>
    <String, dynamic>{
      'android': instance.android?.toJson(),
    };

DeviceInfoAndroid _$DeviceInfoAndroidFromJson(Map<String, dynamic> json) =>
    DeviceInfoAndroid(
      json['brand'] as String,
      json['model'] as String,
      json['android'] as String,
      json['abis'] as String,
      json['fingerprint'] as String,
      json['userAgent'] as String,
      json['userAgent2'] as String,
      json['packageName'] as String,
      json['androidId'] as String,
      json['isRoot'] as bool,
      (json['linkAddress'] as List<dynamic>).map((e) => e as String).toList(),
      json['networkType'] as int,
    );

Map<String, dynamic> _$DeviceInfoAndroidToJson(DeviceInfoAndroid instance) =>
    <String, dynamic>{
      'brand': instance.brand,
      'model': instance.model,
      'android': instance.android,
      'abis': instance.abis,
      'fingerprint': instance.fingerprint,
      'userAgent': instance.userAgent,
      'userAgent2': instance.userAgent2,
      'packageName': instance.packageName,
      'androidId': instance.androidId,
      'isRoot': instance.isRoot,
      'linkAddress': instance.linkAddress,
      'networkType': instance.networkType,
    };
