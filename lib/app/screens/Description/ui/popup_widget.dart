import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pack_app/app/router/export.dart';
import 'package:provider/provider.dart';

class PopupDialog extends StatefulWidget {
  final String fileName;
  final Session session;
  final void Function() toggleParentFileExist;
  final void Function(bool) toggleIsNotVisible;

  const PopupDialog({
    Key? key,
    required this.fileName,
    required this.session,
    required this.toggleParentFileExist,
    required this.toggleIsNotVisible,
  }) : super(key: key);

  @override
  PopupDialogState createState() => PopupDialogState();
}

class PopupDialogState extends State<PopupDialog> {
  bool _hideDialog = false;
  bool _isLoading = false;

  void downloadFile(String savePath) async {
    setState(() {
      _isLoading = true;
    });

    Dio dio = Dio();
    await dio.download(widget.session.track, savePath);

    widget.toggleParentFileExist();
    setState(() {
      _isLoading = false;
    });

    goToBack();
  }

  void goToBack() {
    Navigator.of(context).pop();
  }

  Future<String> getPath() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    setState(() {});
    return '${appDocDir.path}/${widget.fileName}';
  }

  void initializeDownload() async {
    String path = await getPath(); // /path/name.ext
    downloadFile(path);
  }

  void Function(bool?)? onChanged(value) {
    widget.toggleIsNotVisible(value);
    return null;
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
        children: _isLoading
            ? [
                const Text('...Загрузка', style: TextStyle(fontFamily: FontFamily.semiFont, fontSize: 22)),
                const SizedBox(height: 20),
                const CircularProgressIndicator(),
                const SizedBox(height: 20),
                const Text(
                  'Подождите, пока файл сохранится \nна Ваше устройство',
                  style: TextStyle(fontFamily: FontFamily.semiFont, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ]
            : [
                const Text(
                  'Вы можете скачать файл на устройство, для дальнейшего использования \nв отсутствии интернета',
                  style: TextStyle(fontFamily: FontFamily.regularFont, fontSize: 18),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: _hideDialog,
                      onChanged: (value) async {
                        setState(() {
                          _hideDialog = value ?? false;
                        });
                        context.read<DownloadFile>().toggleIsLoading(value);
                        String a = await context.read<DownloadFile>().asyncTest();
                        print(a);
                      },
                    ),
                    Text(
                      'Test ${context.read<DownloadFile>().isLoading.toString()}',
                      style: const TextStyle(
                        fontFamily: FontFamily.regularFont,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
      ),
      actions: _isLoading
          ? []
          : [
              ElevatedButton(
                onPressed: () {
                  initializeDownload();
                },
                child: const Text(
                  "Сохранить",
                  style: TextStyle(
                    fontFamily: FontFamily.regularFont,
                    fontSize: 22,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Отмена",
                  style: TextStyle(
                    fontFamily: FontFamily.regularFont,
                    fontSize: 22,
                  ),
                ),
              ),
            ],
    );
  }
}
