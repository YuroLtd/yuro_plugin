// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_sink.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventSink _$EventSinkFromJson(Map<String, dynamic> json) {
  return EventSink(
    _$enumDecode(_$TidEnumMap, json['tid']),
    json['bid'] as int,
    json['data'],
  );
}

Map<String, dynamic> _$EventSinkToJson(EventSink instance) => <String, dynamic>{
      'tid': _$TidEnumMap[instance.tid],
      'bid': instance.bid,
      'data': instance.data,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$TidEnumMap = {
  Tid.app: 'app',
  Tid.convert: 'convert',
};
