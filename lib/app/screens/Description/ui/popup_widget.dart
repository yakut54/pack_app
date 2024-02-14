import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pack_app/app/router/export.dart';
import 'package:provider/provider.dart';

class PopupDialog extends StatefulWidget {
  final Session session;

  const PopupDialog({
    Key? key,
    required this.session,
  }) : super(key: key);

  @override
  PopupDialogState createState() => PopupDialogState();
}

class PopupDialogState extends State<PopupDialog> {
  void initDownload() {
    context.read<DescriptionApi>().toggleIsLoading(true);
  }

  // Checkbox off/on
  void toggleButtonCallDialodVisible(bool boolean) async {
    DescriptionApi desc = context.read<DescriptionApi>();
    Box<dynamic> box = await HiveBoxVisible().getBox();
    await box.put('isNotVisible', boolean);
    desc.toggleIsNotVisible(boolean);
    await box.close();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DownloadFileApi ctxWD = context.watch<DownloadFileApi>();

    return Container(
      color: AppColors.overlayColor,
      width: MediaQuery.of(context).size.width,
      child: AlertDialog(
        backgroundColor: AppColors.mediumColor,
        contentPadding: const EdgeInsets.only(top: 10, right: 16, bottom: 6, left: 6),
        insetPadding: const EdgeInsets.all(8),
        title: AlertDialogTitleWidget(widget: widget, ctxWD: ctxWD),
        content: Builder(
          builder: (context) {
            var width = MediaQuery.of(context).size.width;
            return SizedBox(
                width: width - 50,
                child: !ctxWD.fileExists
                    ? AlertDialogContentWidget(toggleButtonCallDialodVisible: toggleButtonCallDialodVisible)
                    : const AlertDialogDownloadFileWidget());
          },
        ),
        actions: [
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
              ctxWD.toggleIsFileExist(!ctxWD.fileExists);
              // Navigator.of(context).pop();
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
      ),
    );
  }
}

class AlertDialogTitleWidget extends StatelessWidget {
  const AlertDialogTitleWidget({
    super.key,
    required this.widget,
    required this.ctxWD,
  });

  final PopupDialog widget;
  final DownloadFileApi ctxWD;

  @override
  Widget build(BuildContext context) {
    return Row(
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
              Text(
                ctxWD.getTypeFile(widget.session.type),
                style: const TextStyle(fontFamily: FontFamily.semiFont, fontSize: 22),
              ),
              Text(
                ctxWD.getFileNameExtention(widget.session.track),
                style: const TextStyle(fontFamily: FontFamily.semiFont, fontSize: 22),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AlertDialogContentWidget extends StatelessWidget {
  final void Function(bool)? toggleButtonCallDialodVisible;

  const AlertDialogContentWidget({
    super.key,
    required this.toggleButtonCallDialodVisible,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text(
            'Вы можете скачать файл \n'
            'на устройство, для дальнейшего\n'
            'использования в отсутствии интернета',
            style: TextStyle(fontFamily: FontFamily.regularFont, fontSize: 19),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              value: context.watch<DescriptionApi>().isNotVisible,
              onChanged: (bool? value) {
                toggleButtonCallDialodVisible!(value!);
              },
            ),
            const Text(
              'Больше не показывать',
              style: TextStyle(
                fontFamily: FontFamily.regularFont,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class AlertDialogDownloadFileWidget extends StatelessWidget {
  const AlertDialogDownloadFileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Начинаем загрузку'),
      ],
    );
  }
}
