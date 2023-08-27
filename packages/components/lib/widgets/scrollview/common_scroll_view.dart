import 'package:components/utils/device_util.dart';
import 'package:components/widgets/scrollview/over_scroll_behavior.dart';
import 'package:components/widgets/scrollview/shot_view.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class CommonScrollView extends StatelessWidget {
  const CommonScrollView(
      {Key? key,
      required this.children,
      this.padding,
      this.physics = const BouncingScrollPhysics(),
      this.mainAxisSize = MainAxisSize.max,
      this.crossAxisAlignment = CrossAxisAlignment.start,
      this.contentAlignment = Alignment.topLeft,
      this.bottomButton,
      this.bottomSafe = true,
      this.keyboardConfig,
      this.tapOutsideToDismiss = false,
      this.overScroll = 16.0,
      this.borderRadius,
      this.shotController})
      : super(key: key);

  final List<Widget> children;

  final EdgeInsetsGeometry? padding;

  final ScrollPhysics physics;

  final MainAxisSize mainAxisSize;

  final CrossAxisAlignment crossAxisAlignment;

  final AlignmentGeometry contentAlignment;

  final Widget? bottomButton;

  final bool bottomSafe;

  final KeyboardActionsConfig? keyboardConfig;

  final bool tapOutsideToDismiss;

  final double overScroll;

  final BorderRadius? borderRadius;

  final ShotController? shotController;

  @override
  Widget build(BuildContext context) {
    Widget contents = shotController != null
        ? ShotView(
            controller: shotController,
            child: Column(
              mainAxisSize: mainAxisSize,
              crossAxisAlignment: crossAxisAlignment,
              children: children,
            ),
          )
        : Column(
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
          // ignore: deprecated_member_use
          tapOutsideToDismiss: tapOutsideToDismiss,
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
          bottomSafe ? SafeArea(child: bottomButton!) : bottomButton!
        ],
      );
    }

    return contents;
  }
}
