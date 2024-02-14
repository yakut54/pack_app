import 'dart:io';
import 'app_document_dir.dart';
import 'description_api.dart';

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

  String getTypeFile(type) {
    return type == 'audio' ? 'Аудиофайл' : 'Видеофайл';
  }

  Future<String> getFilePath(String track) async {
    Directory appDocDir = await appDocumentDir(); // Создаём дирректорию для сохранения файлов
    return '${appDocDir.path}/${getFileName(track)}.${getFileExtention(track)}';
  }

  void isFileExists(String filePath) {
    File file = File(filePath);
    fileExists = file.existsSync();
    notifyListeners();
  }

  bool fileExists = true;

  void toggleIsFileExist(bool boolean) {
    fileExists = boolean;
    notifyListeners();
  }
}
