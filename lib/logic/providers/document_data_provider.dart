import 'package:tstore_dart/tstore_dart.dart';

abstract class TDocumentDataProvider extends TDataProvider {
  TDocumentDataProvider({
    required String storeName,
  }) : super(storeName: storeName);

  Future<void> persistDocument(TDocument document) async {
    final oldRaw = await store.toMap();
    final newRaw = document.toJson();
    final changes = _findActualDocumentChanges(oldRaw, newRaw);

    for (var entry in changes.entryToUpdate.entries) {
      await store.persist(entry.key, entry.value);
    }

    for (var key in changes.keyToDelete) {
      await store.delete(key);
    }
  }

  TDocumentChanges _findActualDocumentChanges(
    Map<String, dynamic> oldDocument,
    Map<String, dynamic> newDocument,
  ) {
    final entryToUpdate = <String, dynamic>{};
    final keyToDelete = <String>[];

    oldDocument.forEach((String key, dynamic value) {
      if (newDocument.containsKey(key)) {
        if (oldDocument[key] != newDocument[key]) {
          entryToUpdate[key] = newDocument[key];
        }
      } else {
        keyToDelete.add(key);
      }
    });

    newDocument.forEach((String key, dynamic value) {
      if (!oldDocument.containsKey(key)) {
        entryToUpdate[key] = value;
      }
    });

    return TDocumentChanges(
      entryToUpdate: entryToUpdate,
      keyToDelete: keyToDelete,
    );
  }
}
