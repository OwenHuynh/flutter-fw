import 'package:badges/badges.dart';
import 'package:components/res/image_alias.dart';
import 'package:components/res/res.dart';
import 'package:components/utils/image_util.dart';
import 'package:components/widgets/popups/measure_size.dart';
import 'package:components/widgets/tab_bar/indicator/custom_width_indicator.dart';
import 'package:components/widgets/tab_bar/tabbar_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

typedef TabBarOnTap = Function(TabBarComponentState state, int index);

class TabBarComponent extends StatefulWidget {
  TabBarComponent({
    required this.tabs,
    this.mode = BrnTabBarBadgeMode.average,
    this.isScroll = false,
    this.tabHeight,
    this.padding = EdgeInsets.zero,
    this.controller,
    this.backgroundColor = const Color(0xffffffff),
    this.indicatorColor,
    this.indicatorWeight,
    this.indicatorWidth,
    this.indicatorPadding = EdgeInsets.zero,
    this.labelColor,
    this.labelStyle,
    this.labelPadding = EdgeInsets.zero,
    this.unselectedLabelColor,
    this.unselectedLabelStyle,
    this.dragStartBehavior = DragStartBehavior.start,
    this.onTap,
    this.tabWidth,
    this.hasDivider = false,
    this.hasIndex = false,
    this.showMore = false,
    this.moreWindowText,
    this.onMorePop,
    this.closeController,
    this.tagSpacing,
    this.preLineTagCount,
    this.tagHeight,
  });

  final List<BadgeTab> tabs;

  final BrnTabBarBadgeMode mode;

  final bool isScroll;

  final double? tabHeight;

  final EdgeInsetsGeometry padding;

  final TabController? controller;

  final Color backgroundColor;

  final Color? indicatorColor;

  final double? indicatorWeight;

  final double? indicatorWidth;

  final EdgeInsetsGeometry indicatorPadding;

  final Color? labelColor;

  final TextStyle? labelStyle;

  final EdgeInsetsGeometry labelPadding;

  final Color? unselectedLabelColor;

  final TextStyle? unselectedLabelStyle;

  final DragStartBehavior dragStartBehavior;

  final TabBarOnTap? onTap;

  final bool customIndicator = false;

  final double? tabWidth;

  final bool hasDivider;

  final bool hasIndex;

  final bool showMore;

  final String? moreWindowText;

  final VoidCallback? onMorePop;

  final CloseWindowController? closeController;

  final double? tagSpacing;

  final int? preLineTagCount;

  final double? tagHeight;

  @override
  TabBarComponentState createState() => TabBarComponentState(closeController);
}

enum BrnTabBarBadgeMode { origin, average }

class TabBarComponentState extends State<TabBarComponent> {
  TabBarComponentState(CloseWindowController? closeController) {
    this._closeWindowController = closeController;
  }

  late BadgeShape? _badgeShape = BadgeShape.circle;

  late String? _badgeText;

  late EdgeInsets? _badgePadding = EdgeInsets.all(5);

  late double _paddingTop = -8;

  late double _paddingRight = -18;

  late BorderRadiusGeometry? _borderRadius =
      BorderRadius.all(Radius.circular(8.5));

  final double _moreSpacing = 50;

  CustomTabbarController? _tabbarController;

  CloseWindowController? _closeWindowController;

  @override
  void initState() {
    super.initState();
    _tabbarController = CustomTabbarController();
    _tabbarController?.addListener(() {
      _closeWindowController?.syncWindowState(_tabbarController!.isShow);
      if (widget.controller != null) {
        widget.controller?.animateTo(_tabbarController!.selectIndex);
      }
      refreshBadgeState(_tabbarController!.selectIndex);
      setState(() {});
    });

    _closeWindowController?.getCloseController().stream.listen((event) {
      _tabbarController?.hide();
    });

    widget.controller?.addListener(_handleTabIndexChangeTick);
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller?.removeListener(_handleTabIndexChangeTick);
  }

  void _handleTabIndexChangeTick() {
    if (widget.controller?.index.toDouble() ==
        widget.controller?.animation?.value) {
      _tabbarController?.selectIndex = widget.controller?.index ?? 0;
      _tabbarController?.isShow = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      constraints: BoxConstraints(minHeight: 50),
      color: AppColors.white,
      child: widget.showMore
          ? Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width - _moreSpacing,
                  child: _buildTabBar(),
                ),
                showMoreWidget(context)
              ],
            )
          : _buildTabBar(),
    );
  }

  // 构建TabBar样式
  TabBar _buildTabBar() {
    return TabBar(
        tabs: fillWidgetByDataList(),
        controller: widget.controller,
        isScrollable: widget.tabs.length > 4 ||
            widget.tabWidth != null ||
            widget.isScroll,
        labelColor: widget.labelColor ?? AppStyles.labelStyle.color,
        labelStyle:
            widget.labelStyle ?? AppStyles.labelStyle.generateTextStyle(),
        labelPadding: widget.labelPadding,
        unselectedLabelColor:
            widget.unselectedLabelColor ?? AppStyles.unselectedLabelStyle.color,
        unselectedLabelStyle: widget.unselectedLabelStyle ??
            AppStyles.unselectedLabelStyle.generateTextStyle(),
        dragStartBehavior: widget.dragStartBehavior,
        onTap: (index) {
          if (widget.onTap != null) {
            widget.onTap!(this, index);
            _tabbarController?.setSelectIndex(index);
            _tabbarController?.isShow = false;
          }
        },
        indicator: widget.customIndicator
            ? CustomWidthUnderlineTabIndicator(
                insets: widget.indicatorPadding,
                borderSide: BorderSide(
                  width: 2,
                  color: widget.indicatorColor ?? AppColors.colorLink,
                ),
                width: 56,
              )
            : null);
  }

  // 展开更多Widget
  Widget showMoreWidget(BuildContext context) {
    return Visibility(
      visible: widget.showMore,
      child: GestureDetector(
        onTap: () {
          if (!_tabbarController!.isShow &&
              widget.controller!.index.toDouble() ==
                  widget.controller!.animation!.value) {
            _tabbarController?.show();
            if (widget.onMorePop != null) {
              widget.onMorePop!();
            }
            showMoreWindow(context);
            setState(() {});
          } else {
            hideMoreWindow();
            setState(() {});
          }
        },
        child: Container(
            width: _moreSpacing,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Color(0x05000000),
                    offset: Offset(-3, 0),
                    spreadRadius: -1)
              ],
            ),
            child: !_tabbarController!.isShow
                ? ImageUtils.getAssetImage(ImageAlias.triangleDownIcon)
                : ImageUtils.getAssetImageWithBandColor(
                    ImageAlias.triangleUpIcon)),
      ),
    );
  }

  // 更新选中tab的小红点状态
  void refreshBadgeState(int index) {
    setState(() {
      final BadgeTab badgeTab = widget.tabs[index];
      if (badgeTab.isAutoDismiss) {
        badgeTab
          ..badgeNum = null
          ..badgeText = null
          ..showRedBadge = false;
      }
    });
  }

  List<Widget> fillWidgetByDataList() {
    final List<Widget> widgets = <Widget>[];
    final List<BadgeTab> tabList = widget.tabs;
    if (tabList.isNotEmpty) {
      double minWidth;
      if (widget.tabWidth != null) {
        minWidth = widget.tabWidth!;
      } else {
        final double tabUseWidth = widget.showMore
            ? MediaQuery.of(context).size.width - _moreSpacing
            : MediaQuery.of(context).size.width;
        if (tabList.length <= 4) {
          minWidth = tabUseWidth / tabList.length;
        } else {
          minWidth = tabUseWidth / 4.5;
        }
      }
      for (int i = 0; i < tabList.length; i++) {
        final BadgeTab badgeTab = tabList[i];
        if (widget.mode == BrnTabBarBadgeMode.average) {
          widgets.add(
              _wrapAverageWidget(badgeTab, minWidth, i == tabList.length - 1));
        } else {
          widgets.add(_wrapOriginWidget(badgeTab, i == tabList.length - 1));
        }
      }
    }
    return widgets;
  }

  // 原始的自适应的tab样式
  Widget _wrapOriginWidget(BadgeTab badgeTab, bool lastElement) {
    caculateBadgeParams(badgeTab);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          height: 47,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Visibility(
                  visible: widget.hasIndex && badgeTab.topText != null,
                  child: Text(
                    badgeTab.topText ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
              Badge(
                // ignore: avoid_bool_literals_in_conditional_expressions
                showBadge: (badgeTab.badgeNum != null
                        ? badgeTab.badgeNum! > 0
                        : false) ||
                    badgeTab.showRedBadge ||
                    // ignore: avoid_bool_literals_in_conditional_expressions
                    (badgeTab.badgeText != null
                        ? badgeTab.badgeText!.isNotEmpty
                        : false),
                badgeContent: Text(
                  _badgeText!,
                  style: TextStyle(
                      color: Color(0xFFFFFFFF), fontSize: 10, height: 1),
                ),
                shape: _badgeShape!,
                elevation: 0,
                toAnimate: false,
                borderRadius: _borderRadius!,
                alignment: Alignment.topLeft,
                padding: _badgePadding!,
                position:
                    BadgePosition.topEnd(top: _paddingTop, end: _paddingRight),
                child: Text(badgeTab.text!,
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis),
              )
            ],
          ),
        ),
        Visibility(
          visible: widget.hasDivider && !lastElement,
          child: Container(
            width: 1,
            height: 20,
            color: Color(0xffe4e6f0),
          ),
        )
      ],
    );
  }

  // 定制的等分tab样式
  Widget _wrapAverageWidget(
      BadgeTab badgeTab, double minWidth, bool lastElement) {
    caculateBadgeParams(badgeTab);
    return Container(
      width: minWidth,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: Container(
            alignment: Alignment.center,
            height: 47,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Visibility(
                    visible: widget.hasIndex && badgeTab.topText != null,
                    child: Text(
                      badgeTab.topText ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )),
                Badge(
                  // ignore: avoid_bool_literals_in_conditional_expressions
                  showBadge: (badgeTab.badgeNum != null
                          ? badgeTab.badgeNum! > 0
                          : false) ||
                      badgeTab.showRedBadge ||
                      // ignore: avoid_bool_literals_in_conditional_expressions
                      (badgeTab.badgeText != null
                          ? badgeTab.badgeText!.isNotEmpty
                          : false),
                  badgeContent: Text(
                    _badgeText!,
                    style: TextStyle(
                        color: Color(0xFFFFFFFF), fontSize: 10, height: 1),
                  ),
                  shape: _badgeShape!,
                  elevation: 0,
                  toAnimate: false,
                  borderRadius: _borderRadius!,
                  alignment: Alignment.topLeft,
                  padding: _badgePadding!,
                  position: BadgePosition.topEnd(
                      top: _paddingTop, end: _paddingRight),
                  child: Text(badgeTab.text!,
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis),
                )
              ],
            ),
          )),
          Visibility(
            visible: widget.hasDivider && !lastElement,
            child: Container(
              width: 1,
              height: 20,
              color: Color(0xffe4e6f0),
            ),
          )
        ],
      ),
    );
  }

  void caculateBadgeParams(BadgeTab badgeTab) {
    if (badgeTab.badgeNum != null) {
      if (badgeTab.badgeNum! < 10) {
        _badgePadding = EdgeInsets.all(5);
        _badgeShape = BadgeShape.circle;
        _badgeText = badgeTab.badgeNum?.toString() ?? "";
        _paddingTop = -8;
        _paddingRight = -18;
        _borderRadius = BorderRadius.all(Radius.circular(8.5));
      } else if (badgeTab.badgeNum! > 99) {
        _badgePadding = EdgeInsets.fromLTRB(4, 3, 4, 2);
        _badgeShape = BadgeShape.square;
        _badgeText = "99+";
        _paddingRight = -27;
        _paddingTop = -5;
        _borderRadius = BorderRadius.all(Radius.circular(8.5));
      } else {
        _badgePadding = EdgeInsets.fromLTRB(4, 3, 4, 2);
        _badgeShape = BadgeShape.square;
        _badgeText = badgeTab.badgeNum?.toString() ?? "";
        _paddingTop = -5;
        _paddingRight = -20;
        _borderRadius = BorderRadius.all(Radius.circular(8.5));
      }
    } else {
      if (badgeTab.badgeText != null && badgeTab.badgeText!.isNotEmpty) {
        _badgePadding = EdgeInsets.fromLTRB(5, 3, 5, 2);
        _badgeShape = BadgeShape.square;
        _badgeText = badgeTab.badgeText?.toString() ?? "";
        _paddingTop = -5;
        _paddingRight = -20;
        _borderRadius = BorderRadius.only(
            topLeft: Radius.circular(8.5),
            topRight: Radius.circular(8.5),
            bottomRight: Radius.circular(8.5),
            bottomLeft: Radius.circular(0));
      } else {
        _badgePadding = EdgeInsets.all(4);
        _badgeShape = BadgeShape.circle;
        _badgeText = "";
        _paddingRight = -8;
        _borderRadius = BorderRadius.all(Radius.circular(8.5));
      }
    }
  }

  // 展开更多
  void showMoreWindow(BuildContext context) {
    final RenderBox dropDownItemRenderBox =
        // ignore: cast_nullable_to_non_nullable
        context.findRenderObject() as RenderBox;
    final position =
        dropDownItemRenderBox.localToGlobal(Offset.zero, ancestor: null);
    final size = dropDownItemRenderBox.size;
    _tabbarController!.top = size.height + position.dy;

    final OverlayEntry overlayEntry = OverlayEntry(builder: (context) {
      return GestureDetector(
        onTap: hideMoreWindow,
        onVerticalDragStart: (_) {
          hideMoreWindow();
        },
        onHorizontalDragStart: (_) {
          hideMoreWindow();
        },
        child: Container(
          padding: EdgeInsets.only(
            top: _tabbarController!.top,
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                width: MediaQuery.of(context).size.width,
                left: 0,
                child: Material(
                  color: Color(0xB3000000),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height -
                        _tabbarController!.top,
                    child: Padding(
                      padding: EdgeInsets.all(0),
                      child: _TabBarOverlayWidget(
                        tabs: widget.tabs,
                        moreWindowText: widget.moreWindowText,
                        brnTabbarController: _tabbarController,
                        spacing: 12,
                        preLineTagCount: 4,
                        tagHeight: 32,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
    _tabbarController?.screenHeight = MediaQuery.of(context).size.height;
    if (_tabbarController?.entry != null) {
      resetEntry();
    }
    _tabbarController?.entry = overlayEntry;
    Overlay.of(context)?.insert(_tabbarController!.entry!);
  }

  void resetEntry() {
    _tabbarController?.entry?.remove();
    _tabbarController?.entry = null;
  }

  void hideMoreWindow() {
    if (_tabbarController?.isShow ?? false) {
      _tabbarController?.hide();
      resetEntry();
    }
  }
}

// ignore: must_be_immutable
class _TabBarOverlayWidget extends StatefulWidget {
  _TabBarOverlayWidget(
      {this.tabs,
      this.moreWindowText,
      this.brnTabbarController,
      this.spacing,
      this.preLineTagCount,
      this.tagHeight});

  List<BadgeTab>? tabs;

  String? moreWindowText;

  CustomTabbarController? brnTabbarController;

  double? spacing;

  int? preLineTagCount;

  double? tagHeight;

  @override
  _TabBarOverlayWidgetState createState() => _TabBarOverlayWidgetState();
}

class _TabBarOverlayWidgetState extends State<_TabBarOverlayWidget> {
  double? _tagWidth;

  double _padding = 20;

  double _parentWidth = 0;

  @override
  Widget build(BuildContext context) {
    return createMoreWindowView();
  }

  // 展开更多弹框样式
  Widget createMoreWindowView() {
    return MeasureSize(
      onChange: (size) {
        setState(() {
          _parentWidth = size.width;
        });
      },
      child: Container(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () {},
          onVerticalDragStart: (_) {},
          onHorizontalDragStart: (_) {},
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(20),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Visibility(
                        visible: widget.moreWindowText != null &&
                            widget.moreWindowText!.isNotEmpty,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: Text(
                            widget.moreWindowText ?? "",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff222222),
                                fontWeight: FontWeight.w700),
                          ),
                        )),
                    Container(
                      padding: EdgeInsets.only(top: 12),
                      child: _createMoreItems(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _createMoreItems() {
    // 计算tag的宽度
    _tagWidth = (_parentWidth -
            widget.spacing! * (widget.preLineTagCount! - 1) -
            _padding * 2) /
        widget.preLineTagCount!;

    final List<Widget> widgets = List.empty();
    final List<BadgeTab> tabList = widget.tabs!;
    if (tabList.isNotEmpty) {
      for (int i = 0; i < tabList.length; i++) {
        final BadgeTab badgeTab = tabList[i];
        widgets.add(_createMoreItemWidget(badgeTab, i));
      }
    }
    return Wrap(
      spacing: widget.spacing!,
      runSpacing: 12,
      children: widgets,
    );
  }

  Widget _createMoreItemWidget(BadgeTab badgeTab, int index) {
    return GestureDetector(
      onTap: () {
        if (widget.brnTabbarController!.selectIndex == index) {
          widget.brnTabbarController?.setSelectIndex(index);
          widget.brnTabbarController?.isShow = false;
          widget.brnTabbarController?.entry?.remove();
          widget.brnTabbarController?.entry = null;
          setState(() {});
        } else {
          widget.brnTabbarController!.setSelectIndex(index);
          widget.brnTabbarController?.isShow = false;
          widget.brnTabbarController?.entry?.remove();
          widget.brnTabbarController?.entry = null;
          setState(() {});
        }
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: widget.brnTabbarController!.selectIndex == index
                ? AppColors.tagSelectedBgColor
                : AppColors.colorLink.withAlpha(0x14),
            borderRadius: BorderRadius.circular(RadiusAlias.Radius4)),
        height: widget.tagHeight,
        width: _tagWidth,
        child: Text(
          badgeTab.text!,
          textAlign: TextAlign.center,
          maxLines: 1,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          style: widget.brnTabbarController!.selectIndex == index
              ? AppStyles.tagSelectedTextStyle.generateTextStyle()
              : AppStyles.tagNormalTextStyle.generateTextStyle(),
        ),
      ),
    );
  }
}

class BadgeTab {
  BadgeTab(
      {this.key,
      this.text,
      this.badgeNum,
      this.topText,
      this.badgeText,
      this.showRedBadge = false,
      this.isAutoDismiss = true});

  final Key? key;

  final String? text;

  int? badgeNum;

  String? topText;

  String? badgeText;

  bool showRedBadge;

  bool isAutoDismiss;
}
