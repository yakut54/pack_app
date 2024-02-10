import 'dart:io';

// import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pack_app/app/router/export.dart';
import 'package:path_provider/path_provider.dart';

class PopupDialog extends StatefulWidget {
  final String fileName;
  final Session session;

  const PopupDialog({
    Key? key,
    required this.fileName,
    required this.session,
  }) : super(key: key);

  @override
  PopupDialogState createState() => PopupDialogState();
}

class PopupDialogState extends State<PopupDialog> {
  bool _hideDialog = false;
  String text = 'start';
  String path = 'path';
  // final player = AudioPlayer();

  Future<void> downloadFile(String savePath) async {
    var httpClient = http.Client();
    var request = http.Request(
        'GET', Uri.parse('https://api.selcdn.ru/v1/SEL_53369/mng/_spa_zhensovet/tracks/sekret-dlya-nereshitelnyh.mp3'));
    var response = await httpClient.send(request);

    if (response.statusCode == HttpStatus.ok) {
      var file = File(savePath);
      await response.stream.pipe(file.openWrite());
      print('Файл успешно загружен');
    } else {
      print('Ошибка при загрузке файла');
    }

    httpClient.close();
  }

  // void downloadFile(String savePath) async {
  //   Dio dio = Dio();
  //   Response response = await dio.download(widget.session.track, savePath);

  //   print('response $response');

  //   // try {
  //   // print('downloadFile invoke try >> ${mounted}');

  //   //   Response response = await dio.download(url, savePath);
  //   //   // text = 'Файл успешно скачался: ${response.data}';

  //   //   // if (mounted) {
  //   //   //   // await player.play(DeviceFileSource('$path/audio.mp3'));
  //   //   //   setState(() {});
  //   //   // }
  //   // } catch (e) {
  //   //   print('downloadFile invoke catch >> ${e.toString()}');
  //   //   // text = 'Ошибка загрузки файла: $e';

  //   //   // if (mounted) {
  //   //   //   setState(() {});
  //   //   // }
  //   // }
  // }

  Future<String> getPath() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    path = appDocDir.path;
    setState(() {});
    return '${appDocDir.path}/${widget.fileName}';
  }

  void initializeDownload() async {
    String path = await getPath(); // /path/name.ext
    print('path >> $path');
    downloadFile(path);
  }

  @override
  void initState() {
    super.initState();
    // initializeDownload();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16),
      insetPadding: const EdgeInsets.all(10),
      title: Row(
        children: [
          SizedBox(
            width: 60,
            child: Image.asset(
              'assets/images/__${widget.session.type}__.png',
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.session.type, style: const TextStyle(fontFamily: FontFamily.semiFont, fontSize: 22)),
                Text(widget.fileName, style: const TextStyle(fontFamily: FontFamily.semiFont, fontSize: 22)),
              ],
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Вы можете скачать файл на устройство, для дальнейшего использования \nв отсутствии интернета',
            style: TextStyle(fontFamily: FontFamily.regularFont, fontSize: 18),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                value: _hideDialog,
                onChanged: (value) {
                  setState(() {
                    _hideDialog = value ?? false;
                  });
                },
              ),
              const Text('Больше не показывать', style: TextStyle(fontFamily: FontFamily.regularFont, fontSize: 16)),
            ],
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            initializeDownload();
            Navigator.of(context).pop();
          },
          child: const Text("Сохранить"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Отмена"),
        ),
      ],
    );
  }
}
