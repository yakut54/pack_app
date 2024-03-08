import 'package:flutter/material.dart';
import '/app/imports/all_imports.dart';

class YButton extends StatelessWidget {
  final Function()? onTap;
  final String title;
  const YButton({super.key, this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 15,
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        elevation: MaterialStateProperty.all<double>(0),
        shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xffFF8700),
              Color(0xffF8C740),
              Color(0xffFF8700),
            ],
            stops: [0.0, 0.56, 1.04],
            transform: GradientRotation(135 * 3.14 / 180),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              offset: const Offset(2, 2),
              blurRadius: 3,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 220),
          alignment: Alignment.center,
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: FontFamily.regularFont,
              fontSize: 24,
              letterSpacing: 6,
              height: 2,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
