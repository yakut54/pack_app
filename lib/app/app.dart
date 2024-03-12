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
        listTileTheme: ListTileThemeData(
          tileColor: AppColors.mainColor,
          selectedTileColor: Colors.blue,
          contentPadding: EdgeInsets.all(10), // Add some padding around the tile
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        scaffoldBackgroundColor: AppColors.mediumColor,
      ),
      home: const Menu(),
    );
  }
}
