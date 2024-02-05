import 'package:flutter/material.dart';
import 'package:pack_app/app/router/export.dart';

class PopupDialog extends StatefulWidget {
  final String file;

  const PopupDialog({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  PopupDialogState createState() => PopupDialogState();
}

class PopupDialogState extends State<PopupDialog> {
  bool _hideDialog = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.file, style: TextStyle(fontFamily: FontFamily.semiFont, fontSize: 22)),
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
            Navigator.of(context).pop();
          },
          child: const Text("Oк"),
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
