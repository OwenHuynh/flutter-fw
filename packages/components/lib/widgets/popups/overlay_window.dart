import 'dart:core';
import 'dart:math';
import 'dart:ui';

import 'package:components/widgets/popups/measure_size.dart';
import 'package:flutter/material.dart';

enum OverlayPopDirection { none, top, bottom, left, right }

class OverlayWindow extends StatefulWidget {
  const OverlayWindow({
    required this.context,
    required this.targetKey,
    this.popDirection = OverlayPopDirection.bottom,
    this.content,
  });

  final BuildContext context;

  final GlobalKey targetKey;

  final OverlayPopDirection? popDirection;

  final Widget? content;

  @override
  State<StatefulWidget> createState() {
    return _OverlayWindowState();
  }

  static BrnOverlayController? showOverlayWindow(
      BuildContext context, GlobalKey? targetKey,
      {Widget? content,
      OverlayPopDirection? popDirection,
      bool? autoDismissOnTouchOutSide,
      Function? onDismiss}) {
    assert(content != null);
    assert(targetKey != null);
    assert(content != null);

    if (content == null || targetKey == null) {
      return null;
    }

    BrnOverlayController? overlayController;
    final OverlayEntry entry = OverlayEntry(builder: (context) {
      return GestureDetector(
          behavior: (autoDismissOnTouchOutSide ?? true)
              ? HitTestBehavior.opaque
              : HitTestBehavior.deferToChild,
          onTap: (autoDismissOnTouchOutSide ?? true)
              ? () {
                  overlayController?.removeOverlay();
                  if (onDismiss != null) {
                    onDismiss();
                  }
                }
              : null,
          child: OverlayWindow(
            context: context,
            content: content,
            targetKey: targetKey,
            popDirection: popDirection,
          ));
    });

    return BrnOverlayController._(context, entry)..showOverlay();
  }
}

class _OverlayWindowState extends State<OverlayWindow> {
  late Rect _showRect;

  late Size _screenSize;

  late double _left;
  late double _right;
  late double _top;
  late double _bottom;

  Size _targetViewSize = Size.zero;

  @override
  Widget build(BuildContext context) {
    this._showRect = _getWidgetGlobalRect(widget.targetKey);
    this._screenSize = window.physicalSize / window.devicePixelRatio;
    _calculateOffset();
    return _buildContent();
  }

  Widget _buildContent() {
    final contentPart = Material(
        color: Colors.transparent,
        child: MeasureSize(
            onChange: (size) {
              setState(() {
                _targetViewSize = size;
              });
            },
            child: widget.content!));
    final placeHolderPart = GestureDetector();
    Widget realContent;

    double marginTop =
        _showRect.top + (_showRect.height - _targetViewSize.height) / 2;
    if (_screenSize.height - marginTop < _targetViewSize.height) {
      marginTop = max(0, _screenSize.height - _targetViewSize.height);
    }
    marginTop = max(0, marginTop);

    double marginLeft =
        _showRect.left + (_showRect.width - _targetViewSize.width) / 2;
    if (_screenSize.width - marginLeft < _targetViewSize.width) {
      marginLeft = max(0, _screenSize.width - _targetViewSize.width);
    }
    marginLeft = max(0, marginLeft);

    if (widget.popDirection == OverlayPopDirection.left) {
      realContent = Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: _left.toInt(),
            child: Container(
                padding: EdgeInsets.only(top: marginTop),
                alignment: Alignment.topRight,
                child: contentPart),
          ),
          Expanded(
            flex: (_screenSize.width - _left).toInt(),
            child: placeHolderPart,
          )
        ],
      );
    } else if (widget.popDirection == OverlayPopDirection.right) {
      realContent = Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: _right.toInt(),
            child: placeHolderPart,
          ),
          Expanded(
            flex: (_screenSize.width - _right).toInt(),
            child: Container(
                padding: EdgeInsets.only(top: marginTop),
                alignment: Alignment.topLeft,
                child: contentPart),
          )
        ],
      );
    } else if (widget.popDirection == OverlayPopDirection.top) {
      realContent = Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: _top.toInt(),
            child: Container(
                padding: EdgeInsets.only(top: marginLeft),
                alignment: Alignment.bottomLeft,
                child: contentPart),
          ),
          Expanded(
            flex: (_screenSize.height - _top).toInt(),
            child: placeHolderPart,
          )
        ],
      );
    } else {
      realContent = Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: _bottom.toInt(),
            child: placeHolderPart,
          ),
          Expanded(
            flex: (_screenSize.height - _bottom).toInt(),
            child: Container(alignment: Alignment.topLeft, child: contentPart),
          )
        ],
      );
    }
    return realContent;
  }

  Rect _getWidgetGlobalRect(GlobalKey key) {
    final RenderBox renderBox =
        // ignore: cast_nullable_to_non_nullable
        key.currentContext?.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    return Rect.fromLTWH(
        offset.dx, offset.dy, renderBox.size.width, renderBox.size.height);
  }

  void _calculateOffset() {
    _right = _left = _top = _bottom = 0;
    if (widget.popDirection == OverlayPopDirection.left) {
      _left = _showRect.left;
    } else if (widget.popDirection == OverlayPopDirection.right) {
      _right = _showRect.right;
    } else if (widget.popDirection == OverlayPopDirection.bottom) {
      _bottom = _showRect.bottom;
    } else if (widget.popDirection == OverlayPopDirection.top) {
      _top = _showRect.top;
    }
  }
}

class BrnOverlayController {
  BrnOverlayController._(this.context, this._entry);

  OverlayEntry? _entry;

  BuildContext context;
  bool _isOverlayShowing = false;

  bool get isOverlayShowing => _isOverlayShowing;

  void showOverlay() {
    Overlay.of(context)?.insert(_entry!);
    _isOverlayShowing = true;
  }

  void removeOverlay() {
    _entry?.remove();
    _entry = null;
    _isOverlayShowing = false;
  }
}
