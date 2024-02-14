import 'package:flutter/material.dart';
import '/app/router/export.dart';

class DescriptionApi extends ChangeNotifier {
  bool isLoading = false;

  void toggleIsLoading(bool boolean) {
    isLoading = boolean;
    notifyListeners();
  }

  bool isNotVisible = false;

  void toggleIsNotVisible(bool boolean) {
    isNotVisible = boolean;
    notifyListeners();
  }

  Widget getScreenWidgetBySessionType(Session session) {
    if (session.type == 'audio') {
      return AudioScreen(session: session);
    } else {
      return VideoScreen(session: session);
    }
  }
}
