import 'package:test/test.dart';

import 'package:tstore_dart/tstore_dart.dart';

void main() {
  group('ModelChanges', () {
    late TDocumentChanges modelChanges;
    late TDocumentChanges modelChanges2;

    setUp(() {
      modelChanges = TDocumentChanges(
        keyToDelete: ['age'],
        entryToUpdate: {
          'firstname': 'foo',
          'lastname': 'bar',
        },
      );
      modelChanges2 = TDocumentChanges(
        keyToDelete: ['firstname'],
        entryToUpdate: {'age': 42},
      );
    });

    group('#clone()', () {
      test('should return a copy of a ModelChanges object', () {
        final copy = modelChanges.clone();

        expect(modelChanges == copy, equals(true));
        expect(copy.keyToDelete, equals(['age']));
        expect(
          copy.entryToUpdate,
          equals({'firstname': 'foo', 'lastname': 'bar'}),
        );
      });
    });

    group('#copyWith()', () {
      test('should return a copy of a ModelChanges object', () {
        final copy = modelChanges.copyWith(keyToDelete: ['sex']);

        expect(modelChanges == copy, equals(false));
        expect(copy.keyToDelete, equals(['sex']));
        expect(
          copy.entryToUpdate,
          equals({'firstname': 'foo', 'lastname': 'bar'}),
        );
      });
    });

    group('#merge()', () {
      test('should return a merge two ModelChanges objects', () {
        final copy = modelChanges.merge(modelChanges2);

        expect(modelChanges == copy, equals(false));
        expect(modelChanges2 == copy, equals(true));
        expect(copy.keyToDelete, equals(['firstname']));
        expect(copy.entryToUpdate, equals({'age': 42}));
      });
    });
  });
}
