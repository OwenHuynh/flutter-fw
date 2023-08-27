import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';

class DropdownTransitionItem<T> extends StatefulWidget {
  DropdownTransitionItem({
    Key? key,
    this.scaleFactor = 4.0,
    required this.value,
    required this.itemBuilder,
    this.itemHeight = 48.0,
    this.isSelected = false,
  }) : super(key: key);

  ///Value of item
  final T value;

  ///Defines is this item is selected
  final bool isSelected;

  ///Height of items in list
  final double itemHeight;

  ///Initial item scale
  final scale = ValueNotifier<double>(1);

  ///Opacity unselected item
  final opacity = ValueNotifier<double>(0.5);

  ///the more value the MORE max scale DECREASES
  final double scaleFactor;

  ///Item builder
  final Widget Function(BuildContext context, T value) itemBuilder;

  @override
  State<StatefulWidget> createState() {
    return DropdownTransitionItemState<T>(isSelected: isSelected);
  }

  // ignore: use_setters_to_change_properties
  void updateScale(double scale) {
    this.scale.value = scale;
  }

  // ignore: use_setters_to_change_properties
  void updateOpacity(double opacity) {
    this.opacity.value = opacity;
  }

  Widget getSelectedItem(
      GlobalKey<DropdownTransitionItemState> animatedStateKey,
      dynamic paddingGlobalKey) {
    return RectGetter(
      key: paddingGlobalKey,
      child: DropdownTransitionItem<T>(
        value: value,
        key: animatedStateKey,
        itemHeight: itemHeight,
        itemBuilder: itemBuilder,
        isSelected: true,
      ),
    );
  }
}

class DropdownTransitionItemState<T> extends State<DropdownTransitionItem<T>>
    with SingleTickerProviderStateMixin {
  DropdownTransitionItemState({this.isSelected = false});

  final bool isSelected;

  late AnimationController animationController;

  late Animation _animation;

  late Tween<double> _tween;

  bool isScaled = false;

  Future runScaleTransition({required bool reverse}) {
    if (reverse) {
      return animationController.reverse();
    } else {
      return animationController.forward(from: 0);
    }
  }

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(duration: Duration(milliseconds: 150), vsync: this);
    _tween = Tween(begin: 1, end: 1 + 1 / widget.scaleFactor);
    _animation = _tween.animate(animationController)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    if (isSelected) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.transparent,
              height: widget.itemHeight,
              alignment: AlignmentDirectional.centerStart,
              child: Transform.scale(
                  scale: _animation.value,
                  alignment: Alignment.topLeft,
                  child: widget.itemBuilder(context, widget.value)),
            ),
          ),
        ],
      );
    } else {
      return Material(
        color: Colors.transparent,
        child: Container(
          child: ValueListenableBuilder<double>(
            valueListenable: widget.scale,
            builder: (context, value, child) {
              return Opacity(
                opacity: widget.opacity.value,
                child: Container(
                    height: widget.itemHeight,
                    alignment: AlignmentDirectional.centerStart,
                    child: Transform.scale(
                        scale: value,
                        alignment: Alignment.topLeft,
                        child: widget.itemBuilder(context, widget.value))),
              );
            },
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }
}
