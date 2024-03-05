import '/app/imports/all_imports.dart';

abstract class APackRepo {
  Future<Pack> getPackWrapper();
  Future<Pack> getPacksFromJson(String data);
  Pack getPack(Map<String, dynamic> jsonData);
}
