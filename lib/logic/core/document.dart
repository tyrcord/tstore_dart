import 'package:tstore_dart/tstore_dart.dart';

abstract class TDocument extends TEntity {
  const TDocument();

  @override
  Map<String, dynamic> toJson();
}
