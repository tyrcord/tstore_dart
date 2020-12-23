import 'package:test/test.dart';

import 'package:tstore_dart/tstore_dart.dart';

void main() {
  group('StoreChanges', () {
    StoreChanges storeChanges;
    StoreChanges storeChanges2;

    setUp(() {
      storeChanges = StoreChanges(type: StoreChangeType.delete, key: 'age');
      storeChanges2 = StoreChanges(type: StoreChangeType.delete, value: 42);
    });

    group('#clone()', () {
      test('should return a copy of a StoreChanges object', () {
        final copy = storeChanges.clone();

        expect(storeChanges == copy, equals(true));
        expect(copy.type, equals(StoreChangeType.delete));
      });
    });

    group('#copyWith()', () {
      test('should return a copy of a StoreChanges object', () {
        final copy = storeChanges.copyWith(key: 'foo');

        expect(storeChanges == copy, equals(false));
        expect(copy.type, equals(StoreChangeType.delete));
        expect(copy.key, equals('foo'));
      });
    });

    group('#merge()', () {
      test('should return a merge two StoreChanges objects', () {
        final copy = storeChanges.merge(model: storeChanges2);

        expect(storeChanges == copy, equals(false));
        expect(copy.type, equals(StoreChangeType.delete));
        expect(copy.key, equals('age'));
        expect(copy.value, equals(42));
      });
    });
  });
}