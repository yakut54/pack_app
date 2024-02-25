import 'dart:io';
import 'package:flutter/material.dart';
import '/app/imports/all_imports.dart';

class ImgBlockWidget extends StatelessWidget {
  const ImgBlockWidget({
    Key? key,
    required this.session,
    required this.sessionImgPath,
    required this.isSessionImgExists,
  }) : super(key: key);

  final Session session;
  final String sessionImgPath;
  final bool isSessionImgExists;

  pesda() {
    if (isSessionImgExists) {
      return FileImage(File(sessionImgPath));
    } else {
      return NetworkImage(session.sessionImg);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      padding: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.47),
            blurRadius: 4,
            offset: const Offset(2, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(15.0),
        color: AppColors.darkColor,
      ),
      child: Center(
        child: Column(
          children: [
            FractionallySizedBox(
              widthFactor: 0.9,
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: pesda(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Text(
              session.subscribe.trim().replaceAll(r"\n", "\n"),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: FontFamily.regularFont,
                fontSize: 17,
                height: 1.3,
              ),
            )
          ],
        ),
      ),
    );
  }
}
