import 'dart:io';

import 'package:flutter/material.dart';

class DownloadFile extends ChangeNotifier {
  bool isLoading = false;

  void toggleIsLoading(bool boolean) {
    isLoading = boolean;
    notifyListeners();
  }

  String getFileName(String track) {
    RegExp regex = RegExp(r'\/([^\/]+)\.(mp3|mp4)$');
    Match? match = regex.firstMatch(track);

    if (match != null) {
      String fileName = match.group(1)!;
      return fileName;
    }

    return 'file_name';
  }

  String getFileExtantion(String track) {
    RegExp regex = RegExp(r'\.([a-zA-Z0-9]+)$');
    Match? match = regex.firstMatch(track);

    if (match != null) {
      String extantion = match.group(1)!;
      return extantion;
    }

    return 'mp3';
  }

  String getFileExt(String track) {
    return '${getFileName(track)}.${getFileExtantion(track)}';
  }

  bool isFileExists(String filePath) {
    File file = File(filePath);
    return file.existsSync();
  }
}


// context.read<DownloadFile>().isLoading.toString()