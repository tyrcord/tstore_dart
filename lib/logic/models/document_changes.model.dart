import 'package:flutter/material.dart';

import 'package:tmodel_dart/tmodel_dart.dart';

class TDocumentChanges extends TModel {
  final Map<String, dynamic> entryToUpdate;
  final Iterable<String> keyToDelete;

  const TDocumentChanges({
    @required this.entryToUpdate,
    @required this.keyToDelete,
  })  : assert(entryToUpdate != null),
        assert(keyToDelete != null);

  @override
  TDocumentChanges clone() {
    return TDocumentChanges(
      entryToUpdate: entryToUpdate,
      keyToDelete: keyToDelete,
    );
  }

  @override
  TDocumentChanges copyWith({
    Map<String, dynamic> entryToUpdate,
    Iterable<String> keyToDelete,
  }) {
    return TDocumentChanges(
      entryToUpdate: entryToUpdate ?? this.entryToUpdate,
      keyToDelete: keyToDelete ?? this.keyToDelete,
    );
  }

  @override
  TDocumentChanges merge({@required TDocumentChanges model}) {
    assert(model != null);

    return copyWith(
      entryToUpdate: model.entryToUpdate,
      keyToDelete: model.keyToDelete,
    );
  }

  @override
  List<Object> get props => [entryToUpdate, keyToDelete];
}
