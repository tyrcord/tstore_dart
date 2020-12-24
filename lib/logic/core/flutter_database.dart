import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

import 'package:tstore_dart/tstore_dart.dart';

class TFlutterDataBase extends TDataBaseCore {
  static final TFlutterDataBase _singleton = TFlutterDataBase._();

  factory TFlutterDataBase() => _singleton;

  TFlutterDataBase._();

  @override
  Future<bool> init() async {
    if (!isInitialized) {
      await Hive.initFlutter();
      isInitialized = true;
    }

    return isInitialized;
  }
}
