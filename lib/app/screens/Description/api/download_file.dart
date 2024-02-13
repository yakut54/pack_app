import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DownloadFile extends ChangeNotifier {
  bool isLoading = false;

  void toggleIsLoading(boolean) {
    isLoading = boolean;
    notifyListeners();
  }

  Future<String> asyncTest() async {
    Timer(Duration(milliseconds: 500), () {
      print('Функция setTimeout выполнена');
    });

    Directory appDocDir = await getApplicationDocumentsDirectory();

    print(appDocDir);
    return appDocDir.toString();
  }
}
