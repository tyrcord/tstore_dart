import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:hive/hive.dart';

import 'package:tstore_dart/tstore_dart.dart';

class Store {
  static Future<bool> _disconnectingFuture;
  static Future<bool> _connectingFuture;
  static Future<Box> _boxFuture;

  final _changesController = PublishSubject<StoreChanges>();
  final String key;
  Box<dynamic> _box;

  Stream<StoreChanges> get onChanges => _changesController.stream;

  int get count => _box.length ?? 0;

  Store(this.key);

  Future<bool> connect() async {
    if (_box == null && _boxFuture == null) {
      final completer = Completer<bool>();
      _connectingFuture = completer.future;

      if (_disconnectingFuture != null) {
        await _disconnectingFuture;
      }

      try {
        _boxFuture = Hive.openBox(key);
        _box = await _boxFuture;
        completer.complete(true);
      } catch (error) {
        completer.complete(false);
      } finally {
        _boxFuture = null;
      }
    }

    return _connectingFuture;
  }

  Future<void> disconnect() async {
    if (_disconnectingFuture != null) {
      final completer = Completer<bool>();
      _disconnectingFuture = completer.future;

      if (_connectingFuture != null) {
        await _connectingFuture;
      }

      try {
        if (_boxFuture != null) {
          await _boxFuture;
        }

        if (_box != null) {
          await _box.close();
        }

        completer.complete(true);
      } catch (error) {
        completer.complete(false);
      } finally {
        _boxFuture = null;
        _box = null;
      }
    }

    return _disconnectingFuture;
  }

  Future<dynamic> retrieve(String key) async => _box?.get(key);

  Future<Map<String, dynamic>> retrieveEntity(String key) async {
    return _box?.get(key) as Map<String, dynamic>;
  }

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

  Future<void> persistEntity(String key, Entity entity) async {
    return persist(key, entity.toJson());
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
    return map?.values?.toList() ?? [];
  }

  Future<List<dynamic>> find(bool Function(dynamic) finder) async {
    final list = _box?.values?.where(finder) ?? [];
    return list.toList();
  }

  Future<List<Map<String, dynamic>>> findEntity(
    bool Function(Map<String, dynamic>) finder,
  ) async {
    final values = _box?.values ?? [];

    return values
        .map<Map<String, dynamic>>((dynamic value) {
          return Map<String, dynamic>.from(value as Map<dynamic, dynamic>);
        })
        .where(finder)
        .toList();
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
