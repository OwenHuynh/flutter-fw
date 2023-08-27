import 'package:flutter/material.dart';

class LineComponent extends StatelessWidget {
  const LineComponent({
    required Key key,
    required this.color,
    this.height = 0.5,
    this.leftInset = 0,
    this.rightInset = 0,
  }) : super(key: key);

  final Color color;

  final double height;

  final double leftInset;

  final double rightInset;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: leftInset, right: rightInset),
      child: Divider(
        thickness: height,
        height: height,
        color: color,
      ),
    );
  }
}
