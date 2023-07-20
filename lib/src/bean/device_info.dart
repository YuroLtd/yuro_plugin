import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

import 'network_status.dart';

part 'device_info.g.dart';

@JsonSerializable(explicitToJson: true)
class DeviceInfo extends Object {
  @JsonKey(name: 'android')
  AndroidInfo? android;

  @JsonKey(name: 'ios')
  IosInfo? ios;

  DeviceInfo({
    this.android,
    this.ios,
  });

  factory DeviceInfo.fromJson(Map<String, dynamic> srcJson) => _$DeviceInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DeviceInfoToJson(this);
}

extension DeviceInfoExt on DeviceInfo {
  String? get userAgent2 {
    if (Platform.isAndroid) {
      return android?.userAgent2;
    } else if (Platform.isIOS) {
      return ios?.userAgent2;
    }
    return null;
  }

  String? get packageName{
     if (Platform.isAndroid) {
      return android?.packageName;
    } else if (Platform.isIOS) {
      return ios?.packageName;
    }
    return null;
  }
}

@JsonSerializable()
class IosInfo extends Object {
  @JsonKey(name: 'brand')
  final String brand;

  @JsonKey(name: 'model')
  final String model;

  @JsonKey(name: 'sdk')
  final String sdk;

  @JsonKey(name: 'userAgent')
  final String? userAgent;

  @JsonKey(name: 'userAgent2')
  final String userAgent2;

  @JsonKey(name: 'packageName')
  final String packageName;

  @JsonKey(name: 'udid')
  final String udid;

  IosInfo(
    this.brand,
    this.model,
    this.sdk,
    this.userAgent,
    this.userAgent2,
    this.packageName,
    this.udid,
  );

  factory IosInfo.fromJson(Map<String, dynamic> srcJson) => _$IosInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$IosInfoToJson(this);
}

@JsonSerializable()
class AndroidInfo extends Object {
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

  AndroidInfo(
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

  factory AndroidInfo.fromJson(Map<String, dynamic> srcJson) => _$AndroidInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AndroidInfoToJson(this);
}
