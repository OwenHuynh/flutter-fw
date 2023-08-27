import 'dart:math';

import 'package:flutter/material.dart';

class ToastComponent {
  static const LENGTH_SHORT = 1;
  static const LENGTH_LONG = 2;
  static const BOTTOM = 0;
  static const CENTER = 1;
  static const TOP = 2;

  static _ToastView? preToastView;

  static void showInCenter(String text, BuildContext context, {int? duration}) {
    show(text, context, duration: duration, gravity: CENTER);
  }

  static void show(String text, BuildContext context,
      {int? duration,
      int gravity = BOTTOM,
      Color backgroundColor = const Color(0xFF222222),
      TextStyle textStyle = const TextStyle(fontSize: 16, color: Colors.white),
      double backgroundRadius = 8,
      Image? preIcon,
      double? verticalOffset,
      VoidCallback? onDismiss}) {
    final OverlayState? overlayState = Overlay.of(context);

    if (overlayState == null) {
      return;
    }

    preToastView?._dismiss();
    preToastView = null;

    final newVerticalOffset =
        getRealVerticalOffset(verticalOffset, gravity, context);
    final int aiDuration = duration ?? min(text.length * 0.06 + 0.8, 5).ceil();

    final _ToastView toastView = _ToastView()..overlayState = overlayState;
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(builder: (context) {
      return _buildToastLayout(context, backgroundColor, backgroundRadius,
          preIcon, text, textStyle, gravity,
          verticalOffset: newVerticalOffset);
    });
    toastView._overlayEntry = overlayEntry;
    preToastView = toastView;
    toastView._show(aiDuration, onDismiss: onDismiss);
  }

  static double getRealVerticalOffset(
      double? verticalOffset, int gravity, BuildContext context) {
    final newVerticalOffset;
    if (gravity == ToastComponent.TOP) {
      newVerticalOffset =
          (verticalOffset ?? 0) + MediaQuery.of(context).viewInsets.top + 50;
    } else if (gravity == ToastComponent.BOTTOM) {
      newVerticalOffset =
          (verticalOffset ?? 0) + MediaQuery.of(context).viewInsets.bottom + 50;
    } else {
      newVerticalOffset = 0;
    }
    return newVerticalOffset;
  }
}

_ToastWidget _buildToastLayout(
    BuildContext context,
    Color background,
    double backgroundRadius,
    Image? preIcon,
    String msg,
    TextStyle textStyle,
    int gravity,
    {required double verticalOffset}) {
  Alignment alignment = Alignment.center;
  EdgeInsets padding;

  switch (gravity) {
    case ToastComponent.BOTTOM:
      alignment = Alignment.bottomCenter;
      padding = EdgeInsets.only(bottom: verticalOffset);
      break;
    case ToastComponent.TOP:
      alignment = Alignment.topCenter;
      padding = EdgeInsets.only(top: verticalOffset);
      break;
    default:
      padding = EdgeInsets.only(top: verticalOffset);
  }

  return _ToastWidget(
      widget: Container(
        width: MediaQuery.of(context).size.width,
        child: Container(
            padding: padding,
            alignment: alignment,
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.circular(backgroundRadius),
              ),
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.fromLTRB(18, 10, 18, 10),
              child: RichText(
                text: TextSpan(children: <InlineSpan>[
                  preIcon != null
                      ? WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Padding(
                            padding: EdgeInsets.only(right: 6),
                            child: preIcon,
                          ))
                      : TextSpan(text: ""),
                  TextSpan(text: msg, style: textStyle),
                ]),
              ),
            )),
      ),
      gravity: gravity);
}

class _ToastView {
  late OverlayState overlayState;
  late OverlayEntry _overlayEntry;
  bool _isVisible = false;

  Future<void> _show(int? duration, {VoidCallback? onDismiss}) async {
    _isVisible = true;
    overlayState.insert(_overlayEntry);
    await Future.delayed(Duration(
        seconds: duration == null ? ToastComponent.LENGTH_SHORT : duration));
    await _dismiss();

    if (onDismiss != null) {
      onDismiss();
    }
  }

  Future<void> _dismiss() async {
    if (!_isVisible) {
      return;
    }
    _isVisible = false;
    _overlayEntry.remove();
  }
}

class _ToastWidget extends StatelessWidget {
  _ToastWidget({
    Key? key,
    required this.widget,
    required this.gravity,
  }) : super(key: key);

  final Widget widget;
  final int gravity;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Material(
        color: Colors.transparent,
        child: widget,
      ),
    );
  }
}
