import 'dart:io';
import 'package:flutter/material.dart';
import '/app/router/export.dart';

class FileApi extends ChangeNotifier {
  // Получить информацию о файле из трека
  String getFileInfo(String track, RegExp regex, String defaultValue) {
    Match? match = regex.firstMatch(track);

    if (match != null) {
      return match.group(1)!;
    }

    return defaultValue;
  }

  // Получить имя файла из трека
  String getFileName(String track) => getFileInfo(track, RegExp(r'\/([^\/]+)\.(mp3|mp4)$'), 'file_name');

  // Получить расширение файла из трека
  String getFileExtension(String track) => getFileInfo(track, RegExp(r'\.([a-zA-Z0-9]+)$'), 'mp3');

  // Получить имя файла с расширением из трека
  String getFileNameExtension(String track) => '${getFileName(track)}.${getFileExtension(track)}';

  // Получить путь к файлу с учетом трека
  Future<String> getFilePath(String trackUrl) async {
    Directory appDocDir = await appDocumentDir();
    return '${appDocDir.path}/${getFileNameExtension(trackUrl)}';
  }

  // Проверить, существует ли файл по указанному пути
  static bool isFileExists(String filePath) {
    File file = File(filePath);
    return file.existsSync();
  }
}
