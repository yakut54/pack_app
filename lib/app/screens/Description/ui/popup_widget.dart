import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pack_app/app/router/export.dart';
import 'package:provider/provider.dart';

class PopupDialog extends StatefulWidget {
  final Session session;
  final void Function() toggleParentFileExist;

  const PopupDialog({
    Key? key,
    required this.session,
    required this.toggleParentFileExist,
  }) : super(key: key);

  @override
  PopupDialogState createState() => PopupDialogState();
}

class PopupDialogState extends State<PopupDialog> {
  bool _hideDialog = false;

  void initDownload() {
    context.read<DownloadFile>().toggleIsLoading(true);
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
    DownloadFile ctxWD = context.watch<DownloadFile>();
    DownloadFile ctxRD = context.read<DownloadFile>();

    return AlertDialog(
      contentPadding: const EdgeInsets.only(top: 10, right: 16, bottom: 10, left: 6),
      insetPadding: const EdgeInsets.all(8),
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
      ),
      content: Column(
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
                value: context.read<DownloadFile>().isLoading,
                onChanged: (value) {
                  _hideDialog = value ?? false;
                  setState(() {});
                  ctxRD.toggleIsLoading(_hideDialog);
                  toggleButtonCallDialodVisible(_hideDialog);
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
