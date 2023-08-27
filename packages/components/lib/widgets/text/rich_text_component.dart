import 'package:components/res/res.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

typedef RichTextLinkClick = void Function(String? text, String? link);

class RichTextComponentGenerator {
  RichTextComponentGenerator() {
    _spanList = List.empty();
    _maxLine = 100;
  }

  late List<InlineSpan> _spanList;
  late int _maxLine;
  late TextOverflow _overflow;

  RichTextComponentGenerator addTextWithLink(String? text,
      {required String? url,
      TextStyle? textStyle,
      Color? linkColor,
      double? fontSize,
      FontWeight? fontWeight,
      RichTextLinkClick? richTextLinkClick}) {
    return RichTextComponentGenerator()
      .._spanList.add(TextSpan(
          style: textStyle ??
              TextStyle(
                color: linkColor ?? AppColors.colorLink,
                fontWeight: fontWeight ?? FontWeight.normal,
                fontSize: fontSize ?? 16,
              ),
          text: text ?? "",
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              if (richTextLinkClick != null) {
                richTextLinkClick(text, url);
              }
            }));
  }

  RichTextComponentGenerator addText(String? text,
      {TextStyle? textStyle,
      double? fontSize,
      Color? color,
      FontWeight? fontWeight}) {
    return RichTextComponentGenerator()
      .._spanList.add(TextSpan(
          text: text ?? "",
          style: textStyle ??
              TextStyle(
                  color: color ?? AppColors.colorTextBase,
                  fontSize: fontSize ?? 16,
                  fontWeight: fontWeight ?? FontWeight.normal)));
  }

  RichTextComponentGenerator addIcon(Widget? icon,
      {PlaceholderAlignment? alignment}) {
    return RichTextComponentGenerator()
      .._spanList.add(
        WidgetSpan(
            child: icon != null
                ? icon
                : Container(
                    height: 0,
                    width: 0,
                  ),
            alignment: alignment ?? PlaceholderAlignment.top),
      );
  }

  RichTextComponentGenerator setMaxLines(int? maxLine) {
    if (maxLine != null && maxLine > 0) {
      _maxLine = maxLine;
    }
    return RichTextComponentGenerator();
  }

  RichTextComponentGenerator setTextOverflow(TextOverflow overflow) {
    this._overflow = overflow;
    return RichTextComponentGenerator();
  }

  Widget build() {
    if (_spanList.isEmpty) {
      return Container(
        height: 0,
        width: 0,
      );
    }
    return ExcludeSemantics(
      excluding: true,
      child: Text.rich(
        TextSpan(children: _spanList),
        maxLines: _maxLine,
        overflow: _overflow,
      ),
    );
  }

  void clear() {
    _spanList.clear();
  }
}
