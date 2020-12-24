import 'package:tmodel_dart/tmodel_dart.dart';

abstract class TEntity extends TModel {
  const TEntity();

  Map<String, dynamic> toJson();
}
