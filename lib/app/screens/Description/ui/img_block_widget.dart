import 'package:flutter/material.dart';
import '/app/imports/all_imports.dart';

class ImgBlockWidget extends StatelessWidget {
  const ImgBlockWidget({
    super.key,
    required this.session,
  });

  final Session session;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      padding: const EdgeInsets.symmetric(vertical: 8),
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
              widthFactor: 0.7,
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(session.sessionImg),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Text(
              session.subscribe.trim().replaceAll("\\n", "\n"),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: FontFamily.regularFont,
                fontSize: 16,
                height: 1.3,
              ),
            )
          ],
        ),
      ),
    );
  }
}
