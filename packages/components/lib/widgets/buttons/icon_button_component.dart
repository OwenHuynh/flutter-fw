import 'package:components/res/res.dart';
import 'package:flutter/material.dart';

enum Direction {
  left,
  right,
  top,
  bottom,
}

class IconButtonComponent extends StatefulWidget {
  const IconButtonComponent({
    Key? key,
    required this.name,
    this.iconWidget,
    this.onTap,
    this.iconWidth = 24,
    this.iconHeight = 24,
    this.fontSize = 11,
    this.widgetWidth = 80,
    this.widgetHeight = 80,
    this.direction = Direction.top,
    this.padding = 4,
    this.style,
    this.mainAxisAlignment = MainAxisAlignment.center,
  }) : super(key: key);

  final String name;

  final Widget? iconWidget;

  final VoidCallback? onTap;

  final Direction direction;

  final double iconWidth;

  final double iconHeight;

  final double fontSize;

  final TextStyle? style;

  final double? widgetWidth;

  final double? widgetHeight;

  final double padding;

  final MainAxisAlignment mainAxisAlignment;

  @override
  _IconButtonComponentState createState() => _IconButtonComponentState();
}

class _IconButtonComponentState extends State<IconButtonComponent> {
  @override
  Widget build(BuildContext context) {
    late Container ctn;
    if (widget.direction == Direction.bottom) {
      ctn = Container(
          height: widget.widgetHeight ?? 80,
          width: widget.widgetWidth ?? 80,
          child: Column(
            mainAxisAlignment: widget.mainAxisAlignment,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // 图片
              Container(
                  height: widget.iconHeight,
                  width: widget.iconWidth,
                  child: widget.iconWidget),
              Padding(
                padding: EdgeInsets.only(top: widget.padding),
                child: Text(
                  widget.name,
                  style: widget.style ??
                      TextStyle(
                        fontSize: 11,
                        color: AppColors.colorTextSecondary,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ));
    } else if (widget.direction == Direction.top) {
      ctn = Container(
          height: widget.widgetHeight ?? 80,
          width: widget.widgetWidth ?? 80,
          child: Column(
            mainAxisAlignment: widget.mainAxisAlignment,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: widget.padding),
                child: Text(
                  widget.name,
                  style: widget.style ??
                      TextStyle(
                        fontSize: 11,
                        color: AppColors.colorTextSecondary,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              // 图片
              Container(
                height: widget.iconHeight,
                width: widget.iconWidth,
                child: widget.iconWidget,
              ),
            ],
          ));
    } else if (widget.direction == Direction.left) {
      ctn = Container(
          height: widget.widgetHeight ?? 80,
          width: widget.widgetWidth ?? 80,
          child: Row(
            mainAxisAlignment: widget.mainAxisAlignment,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // 图片
              Container(
                  height: widget.iconHeight,
                  width: widget.iconWidth,
                  child: widget.iconWidget),
              Padding(
                padding: EdgeInsets.only(left: widget.padding),
                child: Text(
                  widget.name,
                  style: widget.style ??
                      TextStyle(
                        fontSize: 11,
                        color: AppColors.colorTextSecondary,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ));
    } else if (widget.direction == Direction.right) {
      ctn = Container(
          height: widget.widgetHeight ?? 80,
          width: widget.widgetWidth ?? 80,
          child: Row(
            mainAxisAlignment: widget.mainAxisAlignment,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: widget.padding),
                child: Text(
                  widget.name,
                  style: widget.style ??
                      TextStyle(
                        fontSize: 11,
                        color: AppColors.colorTextSecondary,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // 图片
              Container(
                  height: widget.iconHeight,
                  width: widget.iconWidth,
                  child: widget.iconWidget),
            ],
          ));
    }

    if (widget.onTap != null) {
      return GestureDetector(
        child: ctn,
        onTap: () {
          widget.onTap!();
        },
      );
    }
    return ctn;
  }
}
