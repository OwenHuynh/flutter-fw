import 'dart:core';
import 'dart:ui';

import 'package:components/res/image_alias.dart';
import 'package:components/res/res.dart';
import 'package:components/utils/image_util.dart';
import 'package:flutter/material.dart';

enum PopupDirection { top, bottom }

// ignore: must_be_immutable
class PopupWindowComponent extends StatefulWidget {
  PopupWindowComponent(this.context,
      {this.text,
      required this.popKey,
      this.arrowHeight,
      this.textStyle,
      this.backgroundColor,
      this.isShowCloseIcon,
      this.offset,
      this.popDirection,
      this.widget,
      this.paddingInsets,
      this.borderRadius,
      this.borderColor,
      this.canWrap = false,
      this.spaceMargin = 20,
      this.arrowOffset,
      this.onDismiss,
      this.turnOverFromBottom = 50.0});

  final BuildContext context;

  final double? arrowHeight;

  final String? text;

  final GlobalKey popKey;

  final TextStyle? textStyle;

  final Color? backgroundColor;

  final Color? borderColor;

  final bool? isShowCloseIcon;

  final double? offset;

  final PopupDirection? popDirection;

  final Widget? widget;

  final EdgeInsets? paddingInsets;

  final double? borderRadius;

  final bool canWrap;

  late double spaceMargin;

  final double? arrowOffset;

  final VoidCallback? onDismiss;

  late double turnOverFromBottom;

  static void showPopWindow(BuildContext context, String text, GlobalKey popKey,
      {PopupDirection popDirection = PopupDirection.bottom,
      double arrowHeight = 6.0,
      TextStyle textStyle =
          const TextStyle(fontSize: 16, color: Color(0xFFFFFFFF)),
      Color backgroundColor = const Color(0xFF1A1A1A),
      bool hasCloseIcon = false,
      double offset = 0,
      Widget? widget,
      EdgeInsets paddingInsets =
          const EdgeInsets.only(left: 18, top: 14, right: 18, bottom: 14),
      double borderRadius = 8,
      Color? borderColor = Colors.transparent,
      double borderWidth = 1,
      bool canWrap = false,
      double spaceMargin = 20,
      double? arrowOffset,
      VoidCallback? dismissCallback,
      double turnOverFromBottom = 50.0}) {
    Navigator.push(
        context,
        PopupRouteComponent(
            child: PopupWindowComponent(
          context,
          arrowHeight: arrowHeight,
          text: text,
          popKey: popKey,
          textStyle: textStyle,
          backgroundColor: backgroundColor,
          isShowCloseIcon: hasCloseIcon,
          offset: offset,
          popDirection: popDirection,
          widget: widget,
          paddingInsets: paddingInsets,
          borderRadius: borderRadius,
          borderColor: borderColor ?? Colors.transparent,
          canWrap: canWrap,
          spaceMargin: spaceMargin,
          arrowOffset: arrowOffset,
          onDismiss: dismissCallback,
          turnOverFromBottom: turnOverFromBottom,
        )));
  }

  @override
  _PopupWindowComponentState createState() => _PopupWindowComponentState();
}

class _PopupWindowComponentState extends State<PopupWindowComponent> {
  late Rect _showRect;

  late Size _screenSize;

  double _arrowSpacing = 18;

  bool _expandedRight = true;

  late double _left;
  late double _right;
  late double _top;
  late double _bottom;

  late PopupDirection _popDirection;

  late Color _borderColor;

  late Color _backgroundColor;

  @override
  void initState() {
    super.initState();
    this._showRect = _getWidgetGlobalRect(widget.popKey);
    this._screenSize = window.physicalSize / window.devicePixelRatio;
    _borderColor = widget.borderColor!.withAlpha(255);
    _backgroundColor = widget.backgroundColor!.withAlpha(255);
    _popDirection = widget.popDirection!;
    _calculateOffset();
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
    if (_showRect.center.dx < _screenSize.width / 2) {
      _expandedRight = true;
      _left = _showRect.left + widget.spaceMargin;
    } else {
      _expandedRight = false;
      _right = _screenSize.width - _showRect.right + widget.spaceMargin;
    }
    if (_popDirection == PopupDirection.bottom) {
      _top = _showRect.height + _showRect.top + widget.offset!;
      if ((_screenSize.height - _top) < widget.turnOverFromBottom) {
        _popDirection = PopupDirection.top;
        _bottom = _screenSize.height - _showRect.top + widget.offset!;
      }
    } else if (_popDirection == PopupDirection.top) {
      _bottom = _screenSize.height - _showRect.top + widget.offset!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      excluding: true,
      child: WillPopScope(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Navigator.pop(context);
              if (widget.onDismiss != null) {
                widget.onDismiss!();
              }
            },
            child: Material(
              color: Colors.transparent,
              child: Stack(
                children: <Widget>[
                  _buildPopWidget(),
                  // triangle arrow
                  _buildArrowWidget(),
                ],
              ),
            ),
          ),
          onWillPop: () {
            if (widget.onDismiss != null) {
              widget.onDismiss!();
            }
            return Future.value(true);
          }),
    );
  }

  Widget _buildArrowWidget() {
    return _expandedRight
        ? Positioned(
            left: widget.arrowOffset ??
                _left +
                    (_showRect.width - _arrowSpacing) / 2 -
                    widget.spaceMargin,
            top: _popDirection == PopupDirection.bottom
                ? _top - widget.arrowHeight!
                : null,
            bottom: _popDirection == PopupDirection.top
                ? _bottom - widget.arrowHeight!
                : null,
            child: CustomPaint(
              size: Size(15, widget.arrowHeight!),
              painter: _TrianglePainter(
                  isDownArrow: _popDirection == PopupDirection.top,
                  color: _backgroundColor,
                  borderColor: _borderColor),
            ),
          )
        : Positioned(
            right: widget.arrowOffset ??
                _right +
                    (_showRect.width - _arrowSpacing) / 2 -
                    widget.spaceMargin,
            top: _popDirection == PopupDirection.bottom
                ? _top - widget.arrowHeight!
                : null,
            bottom: _popDirection == PopupDirection.top
                ? _bottom - widget.arrowHeight!
                : null,
            child: CustomPaint(
              size: Size(15, widget.arrowHeight!),
              painter: _TrianglePainter(
                  isDownArrow: _popDirection == PopupDirection.top,
                  color: _backgroundColor,
                  borderColor: _borderColor),
            ),
          );
  }

  Widget _buildPopWidget() {
    final double statusBarHeight =
        MediaQueryData.fromWindow(window).padding.top;
    return Positioned(
        left: _expandedRight ? _left : null,
        right: _expandedRight ? null : _right,
        top: _popDirection == PopupDirection.bottom ? _top : null,
        bottom: _popDirection == PopupDirection.top ? _bottom : null,
        child: Container(
            padding: widget.paddingInsets,
            decoration: BoxDecoration(
                color: _backgroundColor,
                border: Border.all(color: _borderColor, width: 0.5),
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 4)),
            constraints: BoxConstraints(
                maxWidth: _expandedRight
                    ? _screenSize.width - _left
                    : _screenSize.width - _right,
                maxHeight: _popDirection == PopupDirection.bottom
                    ? _screenSize.height - _top
                    : _screenSize.height - _bottom - statusBarHeight),
            child: widget.widget == null
                ? SingleChildScrollView(
                    child: widget.canWrap
                        ? RichText(
                            text: TextSpan(children: <InlineSpan>[
                            TextSpan(
                                text: widget.text, style: widget.textStyle),
                            widget.isShowCloseIcon!
                                ? WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 6),
                                      child: ImageUtils.getAssetImage(
                                          ImageAlias.popupCloseIcon),
                                    ))
                                : TextSpan(text: "")
                          ]))
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Flexible(
                                fit: FlexFit.loose,
                                child: Text(
                                  widget.text!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: widget.textStyle,
                                ),
                              ),
                              widget.isShowCloseIcon!
                                  ? Padding(
                                      padding: EdgeInsets.only(left: 6),
                                      child: ImageUtils.getAssetImage(
                                          ImageAlias.popupCloseIcon),
                                    )
                                  : Text("")
                            ],
                          ))
                : widget.widget));
  }
}

class _TrianglePainter extends CustomPainter {
  _TrianglePainter({
    required this.isDownArrow,
    required this.color,
    required this.borderColor,
  });

  bool isDownArrow;
  Color color;
  Color borderColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path();
    final Paint paint = Paint()
      ..strokeWidth = 2.0
      ..color = color
      ..style = PaintingStyle.fill;

    if (isDownArrow) {
      path
        ..moveTo(0, -1.5)
        ..lineTo(size.width / 2.0, size.height)
        ..lineTo(size.width, -1.5);
    } else {
      path
        ..moveTo(0, size.height + 1.5)
        ..lineTo(size.width / 2.0, 0)
        ..lineTo(size.width, size.height + 1.5);
    }

    canvas.drawPath(path, paint);
    final Path pathBorder = Path();

    final Paint paintBorder = Paint()
      ..strokeWidth = 0.5
      ..color = borderColor
      ..style = PaintingStyle.stroke;

    if (isDownArrow) {
      pathBorder
        ..moveTo(0, -0.5)
        ..lineTo(size.width / 2.0, size.height)
        ..lineTo(size.width, -0.5);
    } else {
      pathBorder
        ..moveTo(0.5, size.height + 0.5)
        ..lineTo(size.width / 2.0, 0)
        ..lineTo(size.width - 0.5, size.height + 0.5);
    }

    canvas.drawPath(pathBorder, paintBorder);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class PopupRouteComponent extends PopupRoute {
  PopupRouteComponent({required this.child});

  final Duration _duration = Duration(milliseconds: 200);
  Widget child;

  @override
  Color? get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}

typedef PopupListItemClick = Function(int index, String item);

typedef PopupListItemBuilder = Widget Function(int index, String item);

class PopupListWindow {
  static void showButtonPanelPopList(BuildContext context, GlobalKey popKey,
      {List<String>? data,
      PopupDirection popDirection = PopupDirection.bottom,
      PopupListItemBuilder? itemBuilder,
      PopupListItemClick? onItemClick}) {
    final TextStyle textStyle =
        TextStyle(color: AppColors.colorTextBase, fontSize: 16);
    final double arrowHeight = 6;
    final Color borderColor = Color(0xffCCCCCC);
    final Color backgroundColor = Colors.white;
    final double offset = 4;
    final double spaceMargin = -10;
    final double minWidth = 100;
    final double maxWidth = 150;
    final double maxHeight = 200;
    final double borderRadius = 4;
    final bool hasCloseIcon = true;
    Navigator.push(
        context,
        PopupRouteComponent(
            child: PopupWindowComponent(
          context,
          arrowHeight: arrowHeight,
          popKey: popKey,
          textStyle: textStyle,
          backgroundColor: backgroundColor,
          isShowCloseIcon: hasCloseIcon,
          offset: offset,
          widget: data == null || data.isEmpty
              ? Container(
                  constraints:
                      BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
                )
              : Container(
                  constraints:
                      BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(top: 6, bottom: 6),
                      child: Column(
                        children: _getItems(context, minWidth, maxWidth,
                            itemBuilder, textStyle, data, onItemClick, null),
                      ),
                    ),
                  ),
                ),
          popDirection: popDirection,
          borderRadius: borderRadius,
          borderColor: borderColor,
          spaceMargin: spaceMargin,
        )));
  }

  static void showPopListWindow(BuildContext context, GlobalKey popKey,
      {List<String>? data,
      PopupDirection popDirection = PopupDirection.bottom,
      double offset = 0,
      PopupListItemClick? onItemClick,
      VoidCallback? onDismiss}) {
    final double arrowHeight = 6;
    final double borderRadius = 4;
    final double spaceMargin = 0;
    final double minWidth = 100;
    final double maxWidth = 150;
    final double maxHeight = 200;
    double? arrowOffset;
    final Color borderColor = Color(0xFFF0F0F0);
    final Color backgroundColor = Colors.white;
    final TextStyle textStyle =
        TextStyle(color: AppColors.colorTextBase, fontSize: 14);
    final bool hasCloseIcon = true;

    Navigator.push(
        context,
        PopupRouteComponent(
            child: PopupWindowComponent(
          context,
          arrowHeight: arrowHeight,
          popKey: popKey,
          textStyle: textStyle,
          backgroundColor: backgroundColor,
          arrowOffset: arrowOffset,
          isShowCloseIcon: hasCloseIcon,
          offset: offset,
          widget: data == null || data.isEmpty
              ? Container(
                  constraints:
                      BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
                )
              : Container(
                  constraints:
                      BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(top: 6, bottom: 6),
                      child: Column(
                        children: _getItems(context, minWidth, maxWidth, null,
                            textStyle, data, onItemClick, onDismiss),
                      ),
                    ),
                  ),
                ),
          popDirection: popDirection,
          borderRadius: borderRadius,
          borderColor: borderColor,
          spaceMargin: spaceMargin,
          onDismiss: onDismiss,
        )));
  }

  static List<Widget> _getItems(
      BuildContext context,
      double minWidth,
      double maxWidth,
      PopupListItemBuilder? itemBuilder,
      TextStyle? textStyle,
      List<String>? data,
      PopupListItemClick? onItemClick,
      VoidCallback? onDismiss) {
    double textMaxWidth = _getMaxWidth(
        textStyle ?? TextStyle(fontSize: 16, color: Color(0xFFFFFFFF)),
        data ?? List.empty());
    if (textMaxWidth + 52 < minWidth) {
      textMaxWidth = minWidth;
    } else if (textMaxWidth + 52 > maxWidth) {
      textMaxWidth = maxWidth;
    } else {
      textMaxWidth = textMaxWidth + 52;
    }
    return data?.map((f) {
          return GestureDetector(
              onTap: () {
                if (onItemClick != null) {
                  final dynamic isIntercept = onItemClick(data.indexOf(f), f);
                  if ((isIntercept is bool) && isIntercept) {
                    return;
                  }
                }
                Navigator.pop(context);
                if (onDismiss != null) {
                  onDismiss();
                }
              },
              child: Container(
                  width: textMaxWidth,
                  alignment: Alignment.center,
                  color: Colors.transparent,
                  padding:
                      EdgeInsets.only(left: 26, right: 26, top: 6, bottom: 6),
                  child: _getTextWidget(itemBuilder, data, f, textStyle)));
        }).toList() ??
        List.empty();
  }

  static double _getMaxWidth(TextStyle textStyle, List<String> data) {
    double maxWidth = 0;
    if (data.isNotEmpty) {
      Size? maxWidthSize;
      for (final String entity in data) {
        final Size size = textSize(entity, textStyle);
        if (maxWidthSize == null) {
          maxWidthSize = size;
        } else {
          if (maxWidthSize.width < size.width) {
            maxWidthSize = size;
          }
        }
      }
      maxWidth = maxWidthSize!.width;
    }
    return maxWidth;
  }

  static Widget _getTextWidget(PopupListItemBuilder? itemBuilder,
      List<String> data, String text, TextStyle? textStyle) {
    if (itemBuilder == null) {
      return _getDefaultText(text, textStyle);
    } else {
      return itemBuilder(data.indexOf(text), text);
    }
  }

  static Text _getDefaultText(String text, TextStyle? textStyle) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: textStyle ??
          TextStyle(
            fontSize: 16,
            color: Color(0xFFFFFFFF),
          ),
    );
  }

  static Size textSize(String text, TextStyle style) {
    if (text.isEmpty) {
      return Size(0, 0);
    }
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}
