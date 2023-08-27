import 'dart:async';

import 'package:flutter/material.dart';

class CustomTabbarController extends ChangeNotifier {
  late double top;

  bool isShow = false;

  late double screenHeight;

  late OverlayEntry? entry;

  int selectIndex = 0;

  void setSelectIndex(int index) {
    selectIndex = index;
    notifyListeners();
  }

  void show() {
    isShow = true;
    notifyListeners();
  }

  void hide() {
    isShow = false;
    notifyListeners();
  }
}

class CloseWindowEvent {
  CloseWindowEvent({this.isShow});

  bool? isShow = false;
}

class CloseWindowController {
  bool isShow = false;

  StreamController<CloseWindowEvent> _closeController =
      StreamController.broadcast();

  StreamController<CloseWindowEvent> getCloseController() {
    return _closeController;
  }

  // ignore: use_setters_to_change_properties
  void syncWindowState(
      // ignore: avoid_positional_boolean_parameters
      bool state) {
    isShow = state;
  }

  void closeMoreWindow() {
    _closeController.add(CloseWindowEvent());
  }
}
