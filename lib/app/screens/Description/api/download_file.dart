import 'dart:io';
import '/app/router/export.dart';

class DownloadFileApi extends DescriptionApi {
  String getFileName(String track) {
    RegExp regex = RegExp(r'\/([^\/]+)\.(mp3|mp4)$');
    Match? match = regex.firstMatch(track);

    if (match != null) {
      String fileName = match.group(1)!;
      return fileName;
    }

    return 'file_name';
  }

  String getFileExtention(String track) {
    RegExp regex = RegExp(r'\.([a-zA-Z0-9]+)$');
    Match? match = regex.firstMatch(track);

    if (match != null) {
      String extantion = match.group(1)!;
      return extantion;
    }

    return 'mp3';
  }

  String getFileNameExtention(track) {
    return '${getFileName(track)}.${getFileExtention(track)}';
  }

  Future<String> getFilePath(String track) async {
    Directory appDocDir = await appDocumentDir(); // Создаём дирректорию для сохранения файлов
    return '${appDocDir.path}/${getFileName(track)}.${getFileExtention(track)}';
  }

  bool isFileExists(String filePath) {
    File file = File(filePath);
    return file.existsSync();
  }

  String getTypeFile(type) => type == 'audio' ? 'Аудиофайл' : 'Видеофайл';
}
