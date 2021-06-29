import 'package:meta/meta.dart';

import 'package:tstore_dart/tstore_dart.dart';

import '../entities/settings.entity.dart';

class SettingsDocumentDataProvider extends TDocumentDataProvider {
  @override
  @protected
  final TDataBaseCore database = TDataBase();

  SettingsDocumentDataProvider() : super(storeName: 'settings');

  Future<void> persistSettings(SettingsDocument document) {
    return persistDocument(document);
  }

  Future<SettingsDocument> retrieveSettings() async {
    final raw = await store.toMap();

    if (raw.isNotEmpty) {
      return SettingsDocument.fromJson(raw);
    }

    return SettingsDocument();
  }
}
