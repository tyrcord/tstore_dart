import 'package:tmodel_dart/tmodel_dart.dart';

abstract class TEntity extends TModel {
  Map<String, dynamic> toJson();
}
