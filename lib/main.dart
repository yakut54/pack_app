import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/app/imports/all_imports.dart';

void main() {
  GetIt.I.registerLazySingleton<APackRepo>(() => PackRepo());
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => FileApi())],
      child: const App(),
    ),
  );
}
