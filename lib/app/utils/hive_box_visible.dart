import 'dart:io';
import 'package:hive/hive.dart';
import '/app/imports/all_imports.dart';

class HiveBoxVisible {
  Future<Box<dynamic>> getBox() async {
    Directory appDocDir = await appDocumentDir();
    Hive.init(appDocDir.path);

    Box<dynamic> box = await Hive.openBox('visible');
    return box;
  }
}
