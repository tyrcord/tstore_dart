import 'package:equatable/equatable.dart';

abstract class Model extends Equatable {
  dynamic copyWith();
  dynamic merge();
  dynamic clone();
}
