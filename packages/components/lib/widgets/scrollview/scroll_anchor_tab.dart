import 'dart:async';

import 'package:components/widgets/tab_bar/tab_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

typedef AnchorTabWidgetIndexedBuilder = Widget Function(
    BuildContext context, int index);

typedef AnchorTabIndexedBuilder = BadgeTab Function(
    BuildContext context, int index);

class ScrollAnchorTab extends StatefulWidget {
  ScrollAnchorTab(
      {required this.widgetIndexedBuilder,
      required this.tabIndexedBuilder,
      required this.itemCount,
      this.tabDivider,
      this.tabBarStyle = const BrnAnchorTabBarStyle()});

  final BrnAnchorTabBarStyle tabBarStyle;
  final AnchorTabWidgetIndexedBuilder widgetIndexedBuilder;
  final AnchorTabIndexedBuilder tabIndexedBuilder;
  final Widget? tabDivider;

  final int itemCount;

  @override
  _BrnScrollAnchorTabWidgetState createState() =>
      _BrnScrollAnchorTabWidgetState();
}

class _BrnScrollAnchorTabWidgetState extends State<ScrollAnchorTab>
    with SingleTickerProviderStateMixin {
  ScrollController? scrollController;

  StreamController<int>? streamController;

  TabController? tabController;

  GlobalKey? key;

  int? currentIndex;

  late List<Widget> bodyWidgetList;

  late List<GlobalKey> bodyKeyList;

  late List<double> cardOffsetList;

  late List<BadgeTab> tabList;

  bool tab = false;

  double listDy = 0;

  @override
  void initState() {
    streamController = StreamController();
    scrollController = ScrollController();

    key = GlobalKey();
    cardOffsetList = List.filled(widget.itemCount, -1);
    bodyWidgetList = <Widget>[];
    bodyKeyList = <GlobalKey>[];
    tabList = <BadgeTab>[];

    currentIndex = 0;
    tabController = TabController(length: widget.itemCount, vsync: this);

    fillKeyList();
    fillList();
    fillTab();

    WidgetsBinding.instance?.addPostFrameCallback((da) {
      fillOffset();
      scrollController?.addListener(() {
        updateOffset();
        currentIndex = createIndex(scrollController!.offset);
        //防止再次 发送消息
        if (!tab) {
          streamController?.add(currentIndex!);
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        StreamBuilder<int>(
          initialData: currentIndex,
          stream: streamController!.stream,
          builder: (context, snap) {
            tabController!.index = currentIndex!;
            return TabBarComponent(
              indicatorColor: widget.tabBarStyle.indicatorColor,
              indicatorWeight: widget.tabBarStyle.indicatorWeight,
              indicatorPadding: widget.tabBarStyle.indicatorPadding,
              labelColor: widget.tabBarStyle.labelColor,
              labelStyle: widget.tabBarStyle.labelStyle,
              labelPadding: widget.tabBarStyle.labelPadding ?? EdgeInsets.zero,
              unselectedLabelColor: widget.tabBarStyle.unselectedLabelColor,
              unselectedLabelStyle: widget.tabBarStyle.unselectedLabelStyle,
              dragStartBehavior: widget.tabBarStyle.dragStartBehavior,
              controller: tabController,
              tabs: tabList,
              onTap: (state, index) {
                state.refreshBadgeState(index);
                currentIndex = index;
                tab = true;
                scrollController!
                    .animateTo(cardOffsetList[index],
                        duration: Duration(milliseconds: 100),
                        curve: Curves.linear)
                    .whenComplete(() {
                  tab = false;
                });
              },
            );
          },
        ),
        widget.tabDivider ??
            Container(
              height: 0,
              width: 0,
            ),
        Expanded(
          child: SingleChildScrollView(
            key: key,
            controller: scrollController,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: bodyWidgetList,
            ),
          ),
        )
      ],
    );
  }

  void fillList() {
    for (int i = 0; i < widget.itemCount; i++) {
      bodyWidgetList.add(
        Container(
            key: bodyKeyList[i],
            child: widget.widgetIndexedBuilder(context, i)),
      );
    }
  }

  void fillKeyList() {
    for (int i = 0; i < widget.itemCount; i++) {
      bodyKeyList.add(GlobalKey());
    }
  }

  void fillOffset() {
    final Offset globalToLocal =
        (key!.currentContext!.findRenderObject()! as RenderBox)
            .localToGlobal(Offset.zero);
    listDy = globalToLocal.dy;

    for (int i = 0; i < widget.itemCount; i++) {
      if (cardOffsetList[i] == -1.0) {
        if (bodyKeyList[i].currentContext != null) {
          final double cardOffset =
              (bodyKeyList[i].currentContext!.findRenderObject()! as RenderBox)
                  .localToGlobal(Offset.zero)
                  .dy;

          cardOffsetList[i] = cardOffset + scrollController!.offset - listDy;
        }
      }
    }
  }

  void fillTab() {
    for (int i = 0; i < widget.itemCount; i++) {
      tabList.add(widget.tabIndexedBuilder(context, i));
    }
  }

  void updateOffset() {
    for (int i = 0; i < widget.itemCount; i++) {
      if (cardOffsetList[i] == -1.0) {
        if (bodyKeyList[i].currentContext != null) {
          final double cardOffset =
              (bodyKeyList[i].currentContext!.findRenderObject()! as RenderBox)
                  .localToGlobal(Offset.zero) //相对于原点 控件的位置
                  .dy; //y点坐标

          cardOffsetList[i] = cardOffset + scrollController!.offset - listDy;
        }
      }
    }
  }

  int createIndex(double offset) {
    final int index = 0;
    for (int i = 0; i < widget.itemCount; i++) {
      if (offset >= cardOffsetList[i] && (offset <= cardOffsetList[i + 1])) {
        return i;
      }
    }
    return index;
  }

  @override
  void dispose() {
    super.dispose();
    tabController?.dispose();
    streamController?.close();
    scrollController?.dispose();
  }
}

class BrnAnchorTabBarStyle {
  const BrnAnchorTabBarStyle({
    this.indicatorColor,
    this.indicatorWeight = 2.0,
    this.indicatorPadding = EdgeInsets.zero,
    this.labelColor,
    this.labelStyle,
    this.labelPadding,
    this.unselectedLabelColor,
    this.unselectedLabelStyle,
    this.dragStartBehavior = DragStartBehavior.start,
  });

  final Color? indicatorColor;

  final double indicatorWeight;

  final EdgeInsetsGeometry indicatorPadding;

  final Color? labelColor;

  final Color? unselectedLabelColor;

  final TextStyle? labelStyle;

  final EdgeInsetsGeometry? labelPadding;

  final TextStyle? unselectedLabelStyle;

  final DragStartBehavior dragStartBehavior;
}
