import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/app/imports/all_imports.dart';

class PopupDialog extends StatefulWidget {
  final String filePath;
  final Session session;

  const PopupDialog({
    Key? key,
    required this.filePath,
    required this.session,
  }) : super(key: key);

  @override
  PopupDialogState createState() => PopupDialogState();
}

class PopupDialogState extends State<PopupDialog> {
  bool isLoading = false;
  bool isNotVisible = false;
  double downloadProgress = 0;

  goToBack() => Navigator.of(context).pop();

  Future<void> initDownload() async {
    setState(() {
      isLoading = true;
    });
    print('start downloadisLoading $isLoading');

    Dio dio = Dio();

    try {
      await dio.download(
        widget.session.track,
        widget.filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            downloadProgress = received / total;
            setState(() {});
          }
        },
      );
    } catch (e) {
      print('Произошла ошибка при загрузке файла: $e');
    }

    setState(() {
      isLoading = false;
    });

    print('goToBack');
    goToBack();
    print('stop downloadisLoading $isLoading');
  }

  void toggleNotVisible() async {
    isNotVisible = !isNotVisible;
    var box = await HiveBoxVisible().getBox();
    await box.put('isNotVisible', isNotVisible);
    setState(() {});
  }

  void checkIsNotVisible() async {
    var box = await HiveBoxVisible().getBox();
    var isNotVisibleFromBox = box.get('isNotVisible', defaultValue: false);
    if (isNotVisibleFromBox) {
      setState(() {
        isLoading = true;
        print('Запускаем процесс скачивания');
        initDownload();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkIsNotVisible();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16),
      insetPadding: const EdgeInsets.all(10),
      title: Row(
        children: isLoading
            ? []
            : [
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
                      Text(context.watch<FileApi>().getFileNameExtension(widget.session.track),
                          style: const TextStyle(fontFamily: FontFamily.semiFont, fontSize: 22)),
                    ],
                  ),
                ),
              ],
      ),
      content: isLoading
          ? YPreloader(downloadProgress: downloadProgress)
          : Column(
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
                      value: isNotVisible,
                      onChanged: (value) async {
                        toggleNotVisible();
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        toggleNotVisible();
                      },
                      child: const Text(
                        'Больше не показывать',
                        style: TextStyle(
                          fontFamily: FontFamily.regularFont,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
      actions: isLoading ? [] : buttons(),
    );
  }

  List<Widget> buttons() {
    return [
      ElevatedButton(
        onPressed: () {
          initDownload();
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
    ];
  }
}

class YPreloader extends StatelessWidget {
  final double downloadProgress;

  const YPreloader({
    Key? key,
    required this.downloadProgress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text(
            'Идёт загрузка файла\n'
            'Не выключайте телефон\n'
            'и не выходите из приложения.',
            style: TextStyle(fontFamily: FontFamily.semiFont, fontSize: 22),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 30),
        Expanded(
          flex: 0,
          child: Stack(
            children: [
              Align(
                child: SizedBox(
                  width: 90.0,
                  height: 90.0,
                  child: CircularProgressIndicator(
                    color: AppColors.btnColor,
                    backgroundColor: const Color.fromARGB(255, 56, 177, 141),
                    strokeWidth: 20,
                    value: downloadProgress,
                    strokeCap: StrokeCap.round,
                  ),
                ),
              ),
              Positioned(
                left: 0.5,
                right: 0.5,
                bottom: 30,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${(downloadProgress * 100).toStringAsFixed(0)}%',
                        style: const TextStyle(fontSize: 26, fontFamily: FontFamily.semiFont),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
