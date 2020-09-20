import 'package:rxdart/subjects.dart';
import 'package:hive/hive.dart';

import 'package:tstore_dart/tstore_dart.dart';

class Store {
  final _changesController = PublishSubject<StoreChanges>();
  Stream<StoreChanges> get onChanges => _changesController.stream;
  final String key;

  static Future<dynamic> _connection;

  Box<dynamic> _box;

  Store(this.key);

  Future<void> connect() async {
    if (_box == null && _connection == null) {
      _connection = Hive.openBox(key);
      _box = await _connection;
      _connection = null;
    }
  }

  Future<void> disconnect() async {
    if (_connection != null) {
      await _connection;
      _connection = null;
    }

    if (_box != null) {
      await _box.close();
      _box = null;
    }
  }

  Future<dynamic> retrieve(String key) async => _box?.get(key);

  Future<void> persist(String key, dynamic value) async {
    if (_box != null) {
      final update = _box.containsKey(key);
      await _box.put(key, value);
      _notifyChangesListeners(
        update ? StoreChangeType.update : StoreChangeType.add,
        key: key,
        value: value,
      );
    }
  }

  Future<void> delete(String key) async {
    if (_box != null) {
      await _box.delete(key);
      _notifyChangesListeners(StoreChangeType.delete, key: key);
    }
  }

  Future<void> clear() async {
    if (_box != null) {
      await _box.deleteAll(_box.keys);
      _notifyChangesListeners(StoreChangeType.deleteAll);
    }
  }

  Future<List<V>> list<V>() async {
    final map = await toMap<V>();
    return map.values.toList();
  }

  Future<Iterable<dynamic>> find(bool Function(dynamic) finder) async {
    return _box?.values?.where(finder);
  }

  Future<Map<String, V>> toMap<V>() async => _box?.toMap()?.cast<String, V>();

  Stream<BoxEvent> watch({String key}) => _box?.watch(key: key);

  void _notifyChangesListeners(
    StoreChangeType type, {
    String key,
    dynamic value,
  }) {
    _changesController.add(StoreChanges(
      type: type,
      key: key,
      value: value,
    ));
  }
}
