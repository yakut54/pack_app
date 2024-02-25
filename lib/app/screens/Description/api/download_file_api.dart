import 'dart:io';
import 'package:flutter/material.dart';
import '/app/imports/all_imports.dart';

class FileApi extends ChangeNotifier {
  String getFileInfo(String track, RegExp regex, String defaultValue) {
    Match? match = regex.firstMatch(track);

    if (match != null) {
      return match.group(1)!;
    }

    return defaultValue;
  }

  String getFileName(String track) => getFileInfo(track, RegExp(r'\/([^\/]+)\.(mp3|mp4|png|jpg|jpeg)$'), 'file_name');

  String getFileExtension(String track) => getFileInfo(track, RegExp(r'\.([a-zA-Z0-9]+)$'), 'mp3');

  String getFileNameExtension(String track) => '${getFileName(track)}.${getFileExtension(track)}';

  Future<String> getFilePath(String trackUrl) async {
    Directory appDocDir = await appDocumentDir();
    return '${appDocDir.path}/${getFileNameExtension(trackUrl)}';
  }

  static bool isFileExists(String filePath) {
    File file = File(filePath);
    return file.existsSync();
  }
}
