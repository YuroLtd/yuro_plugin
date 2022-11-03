// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkStatus _$NetworkStatusFromJson(Map<String, dynamic> json) =>
    NetworkStatus(
      type: $enumDecodeNullable(_$NetworkTypeEnumMap, json['type']) ??
          NetworkType.none,
      linkAddress: (json['linkAddress'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$NetworkStatusToJson(NetworkStatus instance) =>
    <String, dynamic>{
      'type': _$NetworkTypeEnumMap[instance.type]!,
      'linkAddress': instance.linkAddress,
    };

const _$NetworkTypeEnumMap = {
  NetworkType.cellular: 0,
  NetworkType.wifi: 1,
  NetworkType.bluetooth: 2,
  NetworkType.ethernet: 3,
  NetworkType.vpn: 4,
  NetworkType.wifiAware: 5,
  NetworkType.lowpan: 6,
  NetworkType.usb: 8,
  NetworkType.none: -1,
};
