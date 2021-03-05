import 'package:test/test.dart';

import 'package:tstore_dart/tstore_dart.dart';

void main() {
  group('DataBase', () {
    late TDataBase db;

    setUp(() {
      db = TDataBase();
    });

    group('#constructor()', () {
      test('should return a singleton', () {
        expect(db, equals(TDataBase()));
      });
    });

    group('#getStore()', () {
      test('should create and return a store for a given key', () async {
        final store = await db.getStore('persons');
        expect(store is TStore, equals(true));
      });

      test('should always return the same store for a given key', () async {
        final store = await db.getStore('persons');
        final store2 = await db.getStore('persons');
        final store3 = await db.getStore('cats');

        expect(store is TStore, equals(true));
        expect(store2 is TStore, equals(true));
        expect(store2 != store3, equals(true));
      });
    });
  });
}
