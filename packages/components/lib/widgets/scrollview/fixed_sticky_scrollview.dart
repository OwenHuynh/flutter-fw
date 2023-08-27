import 'package:components/res/res.dart';
import 'package:components/utils/device_util.dart';
import 'package:components/widgets/scrollview/over_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class FixedStickyScrollView extends StatelessWidget {
  const FixedStickyScrollView({
    Key? key,
    required this.children,
    this.padding,
    this.physics = const BouncingScrollPhysics(),
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.contentAlignment = Alignment.topLeft,
    this.bottomButton,
    this.bottomSafe = true,
    this.keyboardConfig,
    this.tapOutsideBehavior = TapOutsideBehavior.translucentDismiss,
    this.overScroll = 16.0,
    this.borderRadius,
  }) : super(key: key);

  final List<Widget> children;

  final EdgeInsetsGeometry? padding;

  final ScrollPhysics physics;

  final MainAxisSize mainAxisSize;

  final CrossAxisAlignment crossAxisAlignment;

  final AlignmentGeometry contentAlignment;

  final Widget? bottomButton;

  final bool bottomSafe;

  final KeyboardActionsConfig? keyboardConfig;

  final TapOutsideBehavior tapOutsideBehavior;

  final double overScroll;

  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    Widget contents = Column(
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      children: children,
    );

    if (borderRadius != null) {
      contents = ClipRRect(borderRadius: borderRadius, child: contents);
    }

    if (DeviceUtil.isIOS && keyboardConfig != null) {
      if (padding != null) {
        contents = Padding(padding: padding!, child: contents);
      }

      contents = KeyboardActions(
          isDialog: bottomButton != null,
          overscroll: overScroll,
          config: keyboardConfig!,
          tapOutsideBehavior: tapOutsideBehavior,
          child: contents);
    } else {
      if (DeviceUtil.isWeb || DeviceUtil.isDesktop) {
        contents = SingleChildScrollView(
          padding: padding,
          physics: physics,
          child: contents,
        );
      } else {
        contents = ScrollConfiguration(
          behavior: OverScrollBehavior(),
          child: SingleChildScrollView(
            padding: padding,
            physics: physics,
            child: contents,
          ),
        );
      }
    }

    if (bottomButton != null) {
      contents = Column(
        children: <Widget>[
          Expanded(
              child: Align(
            alignment: contentAlignment,
            child: contents,
          )),
          bottomSafe
              ? SafeArea(
                  child: Padding(
                      padding: AppStyles.paddingButtonFooter,
                      child: bottomButton))
              : bottomButton!
        ],
      );
    }

    return GestureDetector(
      child: contents,
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
    );
  }
}
