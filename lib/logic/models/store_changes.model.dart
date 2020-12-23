import 'package:meta/meta.dart';

import 'package:tstore_dart/tstore_dart.dart';

class StoreChanges extends Model {
  final StoreChangeType type;
  final dynamic value;
  final String key;

  StoreChanges({
    @required this.type,
    this.value,
    this.key,
  }) : assert(type != null);

  @override
  StoreChanges clone() {
    return StoreChanges(
      value: value,
      type: type,
      key: key,
    );
  }

  @override
  StoreChanges copyWith({
    StoreChangeType type,
    dynamic value,
    String key,
  }) {
    return StoreChanges(
      value: value ?? this.value,
      type: type ?? this.type,
      key: key ?? this.key,
    );
  }

  @override
  StoreChanges merge({@required StoreChanges model}) {
    assert(model != null);

    return copyWith(
      value: model.value,
      type: model.type,
      key: model.key,
    );
  }

  @override
  List<Object> get props => [type, key, value];
}
