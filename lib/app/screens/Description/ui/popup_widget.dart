import 'package:flutter/material.dart';

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
      title: Text(widget.file),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Текст описания здесь'),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Checkbox(
                value: _hideDialog,
                onChanged: (value) {
                  setState(() {
                    _hideDialog = value ?? false;
                  });
                },
              ),
              const Text('Больше не показывать'),
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
