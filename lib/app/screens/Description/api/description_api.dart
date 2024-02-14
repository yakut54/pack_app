import 'package:flutter/material.dart';
import '/app/router/export.dart';

class DescriptionApi extends ChangeNotifier {
  bool isBarrierDismiss = false;

  void toggleIsBarrierDismiss(bool boolean) {
    isBarrierDismiss = boolean;
    notifyListeners();
  }

  bool isNotVisible = false;

  void toggleIsNotVisible(bool boolean) {
    isNotVisible = boolean;
    notifyListeners();
  }

  Widget controllerRouteWidget(Session session) {
    if (session.type == 'audio') {
      return AudioScreen(session: session);
    } else {
      return VideoScreen(session: session);
    }
  }
}
