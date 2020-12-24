import 'dart:io';

import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import 'package:tstore_dart/tstore_dart.dart';

class TDataBase extends TDataBaseCore {
  static final TDataBase _singleton = TDataBase._();

  factory TDataBase() => _singleton;

  TDataBase._();

  @override
  @protected
  Future<bool> init() async {
    if (!isInitialized) {
      var path = Directory.current.path;
      Hive..init(path);
      isInitialized = true;
    }

    return isInitialized;
  }
}
