import 'package:meta/meta.dart';

import 'package:tstore_dart/tstore_dart.dart';

abstract class TDataBaseCore {
  @protected
  final Map<String, TStore> stores = {};
  @protected
  bool isInitialized = false;

  Future<TStore> getStore(String name) async {
    await init();

    if (!stores.containsKey(name)) {
      stores.putIfAbsent(name, () => TStore(name));
    }

    return stores[name];
  }

  @protected
  Future<bool> init();
}
