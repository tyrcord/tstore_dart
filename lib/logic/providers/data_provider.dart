import 'package:meta/meta.dart';

import 'package:tstore_dart/tstore_dart.dart';

abstract class DataProvider {
  @protected
  final DataBase database = DataBase();
  @protected
  final String storeName;
  @protected
  Store store;

  Stream<StoreChanges> get onChanges => store?.onChanges;

  DataProvider({@required this.storeName}) : assert(storeName != null);

  Future<void> connect() async {
    if (store == null) {
      store = await database.getStore(storeName);
      await store.connect();
    }
  }

  Future<void> disconnect() async => store?.disconnect();
}
