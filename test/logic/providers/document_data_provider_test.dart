import 'dart:io';

import 'package:test/test.dart';
import 'package:hive/hive.dart';

import '../../mocks/entities/settings.entity.dart';
import '../../mocks/providers/settings.provider.dart';

void main() {
  var path = Directory.current.path;
  Hive..init(path);

  group('TDocumentDataProvider', () {
    SettingsDocumentDataProvider provider;
    SettingsDocument document;

    setUp(() {
      provider = SettingsDocumentDataProvider();
      document = SettingsDocument(languageCode: 'en');
    });

    group('#persistDocument()', () {
      test('should persit a document', () async {
        await provider.connect();
        await provider.persistDocument(document);
        final document2 = await provider.retrieveSettings();
        expect(document2, equals(document));
      });

      test('should update document', () async {
        await provider.connect();
        await provider.persistDocument(document);
        await provider.persistDocument(
          SettingsDocument(year: 2020, theme: 'dark'),
        );

        final document2 = await provider.retrieveSettings();
        expect(document2, equals(SettingsDocument(year: 2020, theme: 'dark')));
      });
    });
  });
}
