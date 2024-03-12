import 'package:flutter/material.dart';

import '../imports/all_imports.dart';

class FloatingBackButton extends StatelessWidget {
  const FloatingBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      // foregroundColor: AppColors.btnColor,
      mini: true,
      shape: const CircleBorder(
        side: BorderSide(color: AppColors.headerTitleColor, strokeAlign: -4),
      ),
      backgroundColor: AppColors.backButtonColor,
      onPressed: () => Navigator.pop(context),
      child: const Icon(
        color: AppColors.headerTitleColor,
        size: 35,
        Icons.keyboard_arrow_left,
      ),
    );
  }
}
