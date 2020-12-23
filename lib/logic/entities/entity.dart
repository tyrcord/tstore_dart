import 'package:tstore_dart/tstore_dart.dart';

abstract class Entity extends Model {
  Map<String, dynamic> toJson();
}
