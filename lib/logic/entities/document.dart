import 'package:tstore_dart/tstore_dart.dart';

abstract class Document extends Entity {
  @override
  Map<String, dynamic> toJson();
}
