typedef TestMapFunction<K, V> = bool Function(K k, V v);

extension MapExt<K, V> on Map<K, V> {
  Map<K, V> where(TestMapFunction<K, V> test) {
    final list = <MapEntry<K, V>>[];
    entries.forEach((element) {
      if (test(element.key, element.value)) list.add(element);
    });
    return Map.fromEntries(list);
  }
}

extension MapExt2 on Map {
  void deepCast() {
    keys.forEach((key) {
      if (this[key] is Map) {
        this[key] = Map<String, dynamic>.from(this[key])..deepCast();
      }
      if (this[key] is List) {
        var list = this[key] as List;
        this[key] = list.map((e) => Map<String, dynamic>.from(e)..deepCast()).toList();
      }
    });
  }
}
