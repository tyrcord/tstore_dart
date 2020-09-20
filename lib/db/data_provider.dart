import 'package:meta/meta.dart';

import 'package:tstore_dart/tstore_dart.dart';

abstract class DataProvider {
  @protected
  final String storeName;

  @protected
  final DataBase database = DataBase();

  @protected
  Store store;

  Stream<StoreChanges> get onChanges => store?.onChanges;

  DataProvider({
    @required this.storeName,
  });

  Future<void> connect() async {
    if (store == null) {
      store = await database.getStore(storeName);
      await store.connect();
    }
  }

  Future<void> disconnect() async => store?.disconnect();

  @protected
  Future<void> persistModel(Model model) async {
    final oldRaw = await store.toMap();
    final newRaw = model.toJson();
    final changes = _findActualChanges(oldRaw, newRaw);

    for (MapEntry<String, dynamic> entry in changes.entryToUpdate.entries) {
      await store.persist(entry.key, entry.value);
    }

    for (String key in changes.keyToDelete) {
      await store.delete(key);
    }
  }

  _ModelChanges _findActualChanges(
    Map<String, dynamic> oldModel,
    Map<String, dynamic> newModel,
  ) {
    final entryToUpdate = Map<String, dynamic>();
    final keyToDelete = <String>[];

    oldModel.forEach((String key, dynamic value) {
      if (newModel.containsKey(key)) {
        if (oldModel[key] != newModel[key]) {
          entryToUpdate[key] = newModel[key];
        }
      } else {
        keyToDelete.add(key);
      }
    });

    newModel.forEach((String key, dynamic value) {
      if (!oldModel.containsKey(key)) {
        entryToUpdate[key] = value;
      }
    });

    return _ModelChanges(
      entryToUpdate: entryToUpdate,
      keyToDelete: keyToDelete,
    );
  }
}

class _ModelChanges {
  final Map<String, dynamic> entryToUpdate;
  final Iterable<String> keyToDelete;

  _ModelChanges({
    @required this.entryToUpdate,
    @required this.keyToDelete,
  });
}
