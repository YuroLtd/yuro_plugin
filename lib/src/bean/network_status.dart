import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'network_status.g.dart';

@JsonEnum(valueField: 'code')
enum NetworkType {
  cellular(0, 'cellular'),
  wifi(1, 'wifi'),
  bluetooth(2, 'bluetooth'),
  ethernet(3, 'ethernet'),
  vpn(4, 'vpn'),
  wifiAware(5, 'wifiAware'),
  lowpan(6, 'lowpan'),
  usb(8, 'usb'),
  none(-1, 'none');

  final int code;
  final String desc;

  const NetworkType(this.code, this.desc);
}

typedef NetworkStatusListener = void Function(NetworkStatus status);

@JsonSerializable()
class NetworkStatus extends Object with EquatableMixin {
  @JsonKey(name: 'type')
  final NetworkType type;

  @JsonKey(name: 'linkAddress')
  final List<String> linkAddress;

  NetworkStatus({
    this.type = NetworkType.none,
    this.linkAddress = const [],
  });

  factory NetworkStatus.fromJson(Map<String, dynamic> srcJson) => _$NetworkStatusFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NetworkStatusToJson(this);

  @override
  List<Object?> get props => [type, linkAddress];
}
