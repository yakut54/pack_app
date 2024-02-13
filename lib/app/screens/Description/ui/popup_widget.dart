import 'package:flutter/material.dart';
import 'package:pack_app/app/router/export.dart';
import 'package:provider/provider.dart';

class PopupDialog extends StatefulWidget {
  final String fileName;
  final Session session;
  final void Function() toggleParentFileExist;

  const PopupDialog({
    Key? key,
    required this.fileName,
    required this.session,
    required this.toggleParentFileExist,
  }) : super(key: key);

  @override
  PopupDialogState createState() => PopupDialogState();
}

class PopupDialogState extends State<PopupDialog> {
  void initDownload() {}

  @override
  void initState() {
    super.initState();
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
                value: context.read<DownloadFile>().isLoading,
                onChanged: (value) async {
                  setState(() {
                    context.read<DownloadFile>().isLoading = value ?? false;
                  });
                  // context.read<DownloadFile>().toggleIsLoading(value);
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
