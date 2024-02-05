import '/app/router/export.dart';

abstract class APackRepo {
  Future<Pack> getPackWrapper();
  Future<Pack> getPacksFromJson(data);
}
