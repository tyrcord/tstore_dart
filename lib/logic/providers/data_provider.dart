import 'package:meta/meta.dart';

import 'package:tstore_dart/tstore_dart.dart';

abstract class TDataProvider {
  @protected
  final TDataBaseCore database = TFlutterDataBase();
  @protected
  final String storeName;
  @protected
  TStore? store;

  Stream<TStoreChanges> get onChanges => store!.onChanges;

  @mustCallSuper
  TDataProvider({required this.storeName});

  Future<void> connect() async {
    if (store == null) {
      store = await database.getStore(storeName);
      await store!.connect();
    }
  }

  Future<void>? disconnect() async => store!.disconnect();
}
