import 'package:json_annotation/json_annotation.dart';

import 'enum.dart';

part 'event_sink.g.dart';

@JsonSerializable()
class EventSink extends Object {
  @JsonKey(name: 'tid')
  Tid tid;

  @JsonKey(name: 'bid')
  int bid;

  @JsonKey(name: 'data')
  dynamic data;

  EventSink(
    this.tid,
    this.bid,
    this.data,
  );

  factory EventSink.fromJson(Map<String, dynamic> srcJson) => _$EventSinkFromJson(srcJson);

  Map<String, dynamic> toJson() => _$EventSinkToJson(this);
}
