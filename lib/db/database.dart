import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

import 'package:tstore_dart/tstore_dart.dart';

class DataBase {
  static final DataBase _singleton = DataBase._internal();

  bool _isInitialized = false;
  Map<String, Store> _stores = Map<String, Store>();

  factory DataBase() => _singleton;

  DataBase._internal();

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
