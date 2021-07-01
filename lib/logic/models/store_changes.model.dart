import 'package:tmodel_dart/tmodel_dart.dart';
import 'package:tstore_dart/tstore_dart.dart';

class TStoreChanges extends TModel {
  final TStoreChangeType type;
  final dynamic value;
  final String? key;

  const TStoreChanges({
    required this.type,
    this.value,
    this.key,
  });

  @override
  TStoreChanges clone() {
    return TStoreChanges(
      value: value,
      type: type,
      key: key,
    );
  }

  @override
  TStoreChanges copyWith({
    TStoreChangeType? type,
    dynamic value,
    String? key,
  }) {
    return TStoreChanges(
      value: value ?? this.value,
      type: type ?? this.type,
      key: key ?? this.key,
    );
  }

  @override
  TStoreChanges merge(covariant TStoreChanges model) {
    return copyWith(
      value: model.value,
      type: model.type,
      key: model.key,
    );
  }

  @override
  List<Object?> get props => [type, key, value];
}
