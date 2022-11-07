import 'package:json_annotation/json_annotation.dart';

import 'network_status.dart';

part 'device_info.g.dart';

@JsonSerializable(explicitToJson:true)
class DeviceInfo extends Object {
  @JsonKey(name: 'android')
  DeviceInfoAndroid? android;

  DeviceInfo({
    this.android,
  });

  factory DeviceInfo.fromJson(Map<String, dynamic> srcJson) => _$DeviceInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DeviceInfoToJson(this);
}

@JsonSerializable()
class DeviceInfoAndroid extends Object {
  @JsonKey(name: 'brand')
  final String brand;

  @JsonKey(name: 'model')
  final String model;

  @JsonKey(name: 'sdk')
  final String sdk;

  @JsonKey(name: 'abis')
  final String abis;

  @JsonKey(name: 'userAgent')
  final String userAgent;

  @JsonKey(name: 'userAgent2')
  final String userAgent2;

  @JsonKey(name: 'packageName')
  final String packageName;

  @JsonKey(name: 'androidId')
  final String androidId;

  @JsonKey(name: 'isRoot')
  final bool isRoot;

  @JsonKey(name: 'linkAddress')
  final List<String> linkAddress;

  @JsonKey(name: 'networkType')
  final NetworkType networkType;

  DeviceInfoAndroid(
    this.brand,
    this.model,
    this.sdk,
    this.abis,
    this.userAgent,
    this.userAgent2,
    this.packageName,
    this.androidId,
    this.isRoot,
    this.linkAddress,
    this.networkType,
  );

  factory DeviceInfoAndroid.fromJson(Map<String, dynamic> srcJson) => _$DeviceInfoAndroidFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DeviceInfoAndroidToJson(this);
}
