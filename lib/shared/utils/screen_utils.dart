import 'package:flutter/material.dart';

class ScreenUtils {
  static Size size(BuildContext context) => MediaQuery.of(context).size;

  static double width(BuildContext context) => size(context).width;

  static double height(BuildContext context) => size(context).height;

  static double appBarHeight() => kToolbarHeight;
}

extension MediaQueryExtension on BuildContext {
  Size get size => ScreenUtils.size(this);

  double get height => ScreenUtils.size(this).height;

  double get width => ScreenUtils.size(this).width;

  double get appBarHeight => ScreenUtils.appBarHeight();
}
