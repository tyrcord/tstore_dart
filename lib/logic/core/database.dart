import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

import 'package:tstore_dart/tstore_dart.dart';

class DataBase {
  static final DataBase _singleton = DataBase._();

  final Map<String, Store> _stores = {};
  bool _isInitialized = false;

  factory DataBase() => _singleton;

  DataBase._();

  Future<Store> getStore<E>(String name) async {
    await _init();

    if (!_stores.containsKey(name)) {
      _stores.putIfAbsent(name, () => Store(name));
    }

    return _stores[name];
  }

  Future<bool> _init() async {
    if (!_isInitialized) {
      await Hive.initFlutter();
      _isInitialized = true;
    }

    return _isInitialized;
  }
}
