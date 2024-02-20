import 'package:flutter/material.dart';
import '/app/imports/all_imports.dart';

class contentBlockWidget extends StatelessWidget {
  const contentBlockWidget({
    super.key,
    required this.session,
  });

  final Session session;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1.0,
      color: Colors.white.withOpacity(0.8),
      padding: const EdgeInsets.all(8.0),
      child: Text(
        session.description.trim().replaceAll("\\n", "\n"),
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 20.0,
          fontFamily: FontFamily.regularFont,
        ),
      ),
    );
  }
}
