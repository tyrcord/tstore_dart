import 'package:flutter/material.dart';

import 'package:tstore_dart/tstore_dart.dart';

class DocumentChanges extends Model {
  final Map<String, dynamic> entryToUpdate;
  final Iterable<String> keyToDelete;

  DocumentChanges({
    @required this.entryToUpdate,
    @required this.keyToDelete,
  })  : assert(entryToUpdate != null),
        assert(keyToDelete != null);

  @override
  DocumentChanges clone() {
    return DocumentChanges(
      entryToUpdate: entryToUpdate,
      keyToDelete: keyToDelete,
    );
  }

  @override
  DocumentChanges copyWith({
    Map<String, dynamic> entryToUpdate,
    Iterable<String> keyToDelete,
  }) {
    return DocumentChanges(
      entryToUpdate: entryToUpdate ?? this.entryToUpdate,
      keyToDelete: keyToDelete ?? this.keyToDelete,
    );
  }

  @override
  DocumentChanges merge({@required DocumentChanges model}) {
    assert(model != null);

    return copyWith(
      entryToUpdate: model.entryToUpdate,
      keyToDelete: model.keyToDelete,
    );
  }

  @override
  List<Object> get props => [entryToUpdate, keyToDelete];
}
