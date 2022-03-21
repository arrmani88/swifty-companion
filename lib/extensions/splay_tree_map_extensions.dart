import 'dart:collection';

extension SplayTreeMapExtension<K, V> on SplayTreeMap<K, List<V>> {
  void addStudent(K key, V value) {
    (this[key] ??= []).add(value);
  }
}
