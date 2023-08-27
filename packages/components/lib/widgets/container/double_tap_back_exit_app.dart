import 'package:components/res/colors.dart';
import 'package:components/widgets/snack_bar/snack_bar_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DoubleTapBackExitApp extends StatefulWidget {
  const DoubleTapBackExitApp({
    Key? key,
    required this.child,
    this.textMessage,
    this.duration = const Duration(milliseconds: 2500),
  }) : super(key: key);

  final Widget child;

  final Duration duration;

  final String? textMessage;

  @override
  _DoubleTapBackExitAppState createState() => _DoubleTapBackExitAppState();
}

class _DoubleTapBackExitAppState extends State<DoubleTapBackExitApp> {
  DateTime? _lastTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _isExit,
      child: widget.child,
    );
  }

  Future<bool> _isExit() async {
    if (_lastTime == null ||
        DateTime.now().difference(_lastTime!) > widget.duration) {
      _lastTime = DateTime.now();
      SnackBarInfo(widget.textMessage ?? "Click again to exit the app",
              ScaffoldMessenger.of(context), AppColors.info)
          .show();
      return Future.value(false);
    }

    await SystemNavigator.pop();
    return Future.value(true);
  }
}
