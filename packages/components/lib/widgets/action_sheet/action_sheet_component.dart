import 'dart:ui';

import 'package:components/res/res.dart';
import 'package:flutter/material.dart';

typedef void CommonActionSheetItemClickCallBack(
    int index, CommonActionSheetItem actionItem);
typedef bool CommonActionSheetItemClickInterceptor(
    int index, CommonActionSheetItem actionItem);

enum CommonActionSheetItemStyle {
  normal,
  link,
  alert,
}

class CommonActionSheetItem {
  CommonActionSheetItem(
    this.title, {
    this.desc,
    this.actionStyle: CommonActionSheetItemStyle.normal,
    this.titleStyle,
    this.descStyle,
  });

  String title;

  String? desc;

  final CommonActionSheetItemStyle actionStyle;

  final TextStyle? titleStyle;

  final TextStyle? descStyle;
}

// ignore: must_be_immutable
class ActionSheetComponent extends StatelessWidget {
  ActionSheetComponent({
    required this.actions,
    this.title,
    this.titleWidget,
    this.cancelTitle,
    this.clickCallBack,
    this.separatorLineColor,
    this.spaceColor = const Color(0xfff8f8f8),
    this.maxTitleLines = 2,
    this.maxSheetHeight = 0,
    this.onItemClickInterceptor,
  });

  final List<CommonActionSheetItem> actions;

  final String? title;

  final Widget? titleWidget;

  final Color? separatorLineColor;

  final Color? spaceColor;

  final String? cancelTitle;

  final int? maxTitleLines;

  final double maxSheetHeight;

  final CommonActionSheetItemClickCallBack? clickCallBack;

  final CommonActionSheetItemClickInterceptor? onItemClickInterceptor;

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQueryData.fromWindow(window).padding;
    final double maxHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;

    double _maxSheetHeight = 0;

    if (maxSheetHeight <= 0 || maxSheetHeight > maxHeight) {
      _maxSheetHeight = maxHeight;
    }
    return GestureDetector(
      child: Container(
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(RadiusAlias.Radius8),
                topRight: Radius.circular(RadiusAlias.Radius8),
              ),
            ),
          ),
          child:
              SafeArea(child: _configActionWidgets(context, _maxSheetHeight))),
      onVerticalDragUpdate: (v) => {},
    );
  }

  Widget _configActionWidgets(BuildContext context, double _maxSheetHeight) {
    final List<Widget> widgets = <Widget>[];
    if (titleWidget != null) {
      widgets.add(titleWidget!);
    } else if (title != null && title.toString().trim() != "") {
      widgets.add(_configTitleActions());
    }
    widgets
      ..add(_configListActions(context))
      ..add(Divider(
        color: spaceColor ?? Color(0xfff8f8f8),
        thickness: 8,
        height: 8,
      ))
      ..add(_configCancelAction(context));

    return Container(
      constraints: BoxConstraints(maxHeight: _maxSheetHeight),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: widgets,
      ),
    );
  }

  Widget _configTitleActions() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 16, bottom: 16, left: 60, right: 60),
          child: Center(
            child: Text(
              title!,
              textAlign: TextAlign.center,
              maxLines: maxTitleLines,
              style: AppStyles.titleStyle.generateTextStyle(),
            ),
          ),
        ),
        Divider(
          thickness: 1,
          height: 1,
          color: separatorLineColor ?? AppColors.dividerColorBase,
        ),
      ],
    );
  }

  Widget _configListActions(BuildContext context) {
    final List<Widget> tiles = <Widget>[];
    for (int index = 0; index < actions.length; index++) {
      tiles
        ..add(
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding:
                  EdgeInsets.only(top: 12, bottom: 12, left: 60, right: 60),
              child: _configTile(actions[index]),
            ),
            onTap: () {
              if (onItemClickInterceptor == null ||
                  !onItemClickInterceptor!(index, actions[index])) {
                if (clickCallBack != null) {
                  clickCallBack!(index, actions[index]);
                }
                Navigator.of(context).pop([index, actions[index]]);
              }
            },
          ),
        )
        ..add(Divider(
          thickness: 1,
          height: 1,
          color: separatorLineColor ?? AppColors.dividerColorBase,
        ));
    }
    return Flexible(
      child: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: tiles,
      ),
    );
  }

  Widget _configTile(CommonActionSheetItem action) {
    final List<Widget> tileElements = <Widget>[];
    bool hasTitle = false;
    tileElements.add(Center(
      child: Text(
        action.title,
        maxLines: 1,
        style: action.titleStyle ??
            (action.actionStyle == CommonActionSheetItemStyle.alert
                ? AppStyles.itemTitleStyleAlert.generateTextStyle()
                : (action.actionStyle == CommonActionSheetItemStyle.link
                    ? AppStyles.itemTitleStyleLink.generateTextStyle()
                    : AppStyles.itemTitleStyle.generateTextStyle())),
      ),
    ));
    hasTitle = true;
    if (action.desc != null) {
      if (hasTitle) {
        tileElements.add(SizedBox(
          height: 2,
        ));
      }
      tileElements.add(
        Center(
          child: Text(
            action.desc!,
            textAlign: TextAlign.center,
            maxLines: 1,
            style: action.descStyle ??
                (action.actionStyle == CommonActionSheetItemStyle.alert
                    ? AppStyles.itemDescStyleAlert.generateTextStyle()
                    : (action.actionStyle == CommonActionSheetItemStyle.link
                        ? AppStyles.itemDescStyleLink.generateTextStyle()
                        : AppStyles.itemDescStyle.generateTextStyle())),
          ),
        ),
      );
    }
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: tileElements),
    );
  }

  Widget _configCancelAction(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        color: Color(0xffffffff),
        padding: EdgeInsets.only(top: 12, bottom: 12),
        child: Center(
          child: Text(
            (cancelTitle != null) ? cancelTitle! : "Cancel",
            style: AppStyles.cancelStyle.generateTextStyle(),
          ),
        ),
      ),
    );
  }
}
