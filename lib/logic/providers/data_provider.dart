import 'package:meta/meta.dart';

import 'package:tstore_dart/tstore_dart.dart';

abstract class TDataProvider {
  bool _isConnecting = false;
  bool _isConnected = false;
  TStore? _store;

  @protected
  final TDataBaseCore database = TFlutterDataBase();
  @protected
  final String storeName;
  @protected
  TStore get store {
    assert(_store != null, 'the method `connect` should be called first');

    return _store!;
  }

  Stream<TStoreChanges> get onChanges => store.onChanges;

  @mustCallSuper
  TDataProvider({required this.storeName});

  Future<bool> connect() async {
    if (!_isConnecting && !_isConnected) {
      _isConnecting = true;
      _store = await database.getStore(storeName);
      _isConnected = await store.connect();
      _isConnecting = false;
    }

    return _isConnected;
  }

  Future<bool> disconnect() async {
    _isConnected = await store.disconnect();

    return _isConnected;
  }
}
