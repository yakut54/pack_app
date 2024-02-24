import 'package:flutter/material.dart';
import '/app/imports/all_imports.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Packs 2.0',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.mediumColor,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainColor),
        useMaterial3: true,
      ),
      home: const Menu(),
    );
  }
}
