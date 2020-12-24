import 'package:tstore_dart/tstore_dart.dart';

abstract class TDocument extends TEntity {
  @override
  Map<String, dynamic> toJson();
}
