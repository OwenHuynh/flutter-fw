import 'package:components/res/res.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

typedef TextExpandedCallback = Function(bool);

class ExpandableTextComponent extends StatefulWidget {
  const ExpandableTextComponent(
      {Key? key,
      required this.text,
      this.maxLines = 1000000,
      this.textStyle,
      this.onExpanded,
      this.color})
      : super(key: key);

  final String text;

  final int? maxLines;

  final TextStyle? textStyle;

  final TextExpandedCallback? onExpanded;

  final Color? color;

  _ExpandableTextComponentState createState() =>
      _ExpandableTextComponentState();
}

class _ExpandableTextComponentState extends State<ExpandableTextComponent> {
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = false;
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle style = _defaultTextStyle();
    return LayoutBuilder(
      builder: (context, size) {
        final span = TextSpan(text: widget.text, style: style);
        final tp = TextPainter(
            text: span,
            maxLines: widget.maxLines,
            textDirection: TextDirection.ltr,
            ellipsis: 'EllipseText')
          ..layout(maxWidth: size.maxWidth);

        if (tp.didExceedMaxLines) {
          if (this._expanded) {
            return _expandedText(context, widget.text);
          } else {
            return _foldedText(context, widget.text);
          }
        } else {
          return _regularText(widget.text, style);
        }
      },
    );
  }

  Widget _foldedText(context, String text) {
    return Stack(
      children: <Widget>[
        Text(
          widget.text,
          style: _defaultTextStyle(),
          maxLines: widget.maxLines,
          overflow: TextOverflow.clip,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: _clickExpandTextWidget(context),
        )
      ],
    );
  }

  Widget _clickExpandTextWidget(context) {
    final Color btnColor = widget.color ?? Colors.white;

    final Text tx = Text(
      'More',
      style: TextStyle(color: AppColors.colorLink, fontSize: 14),
    );
    final Container cnt = Container(
      padding: EdgeInsets.only(left: 22),
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [btnColor.withAlpha(100), btnColor, btnColor],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      )),
      child: tx,
    );
    return GestureDetector(
      child: cnt,
      onTap: () {
        setState(() {
          _expanded = true;
          if (null != widget.onExpanded) {
            widget.onExpanded!(_expanded);
          }
        });
      },
    );
  }

  Widget _expandedText(context, String text) {
    return RichText(
        textScaleFactor: MediaQuery.of(context).textScaleFactor,
        text: TextSpan(text: text, style: _defaultTextStyle(), children: [
          _foldButtonSpan(context),
        ]));
  }

  TextStyle _defaultTextStyle() {
    final TextStyle style = widget.textStyle ??
        TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.colorTextBase,
        );
    return style;
  }

  InlineSpan _foldButtonSpan(context) {
    return TextSpan(
        text: ' Acquired',
        style: TextStyle(
          color: AppColors.colorLink,
          fontSize: 14,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            setState(() {
              _expanded = false;
              if (null != widget.onExpanded) {
                widget.onExpanded!(_expanded);
              }
            });
          });
  }

  Widget _regularText(text, style) {
    return Text(text, style: style);
  }
}
