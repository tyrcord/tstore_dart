import 'package:meta/meta.dart';

import 'package:tstore_dart/tstore_dart.dart';

class StoreChanges {
  final StoreChangeType type;
  final String key;
  final dynamic value;

  StoreChanges({
    @required this.type,
    this.key,
    this.value,
  }) : assert(type != null);
}
