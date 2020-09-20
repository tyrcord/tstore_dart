abstract class Model {
  Map<String, dynamic> toJson();
  dynamic copyWith();
  dynamic merge();
}
