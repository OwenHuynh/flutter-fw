import 'dart:async';

import 'package:components/widgets/dropdown/dropdown_transition/dropdown_transition_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rect_getter/rect_getter.dart';

class DropdownTransitionContainer extends StatefulWidget {
  const DropdownTransitionContainer({
    Key? key,
    required this.child,
    this.dragSpeedMultiplier = 2,
    this.decoration,
  }) : super(key: key);

  ///Actually content of screen
  final Widget child;

  ///How fast list is scrolled
  final int dragSpeedMultiplier;

  ///Decoration for the DSL container
  final Decoration? decoration;

  @override
  State<StatefulWidget> createState() {
    return DropdownTransitionContainerState();
  }

  static DropdownTransitionGestureEventListeners of(BuildContext context) {
    if (context.dependOnInheritedWidgetOfExactType<
            _InheritedContainerListeners>() ==
        null) {
      throw Exception("A DropdownTransitionList "
          "must inherit a DropdownTransitionContainer!");
    }
    return context
        .dependOnInheritedWidgetOfExactType<_InheritedContainerListeners>()!
        .listeners;
  }
}

class DropdownTransitionContainerState
    extends State<DropdownTransitionContainer>
    with SingleTickerProviderStateMixin
    implements DropdownTransitionGestureEventListeners {
  bool isOverlayVisible = false;

  late ScrollController _scrollController;
  DropdownTransitionList _currentList =
      DropdownTransitionList(itemBuilder: (val) => null, values: []);
  double _currentScrollLocation = 0;

  double _adjustedTopOffset = 0;

  late AnimationController fadeAnimationController;

  int lastSelectedItem = 0;

  double listPadding = 0;

  final scrollToListElementAnimationDuration = Duration(milliseconds: 200);
  final fadeAnimationDuration = Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();

    fadeAnimationController = AnimationController(
      duration: fadeAnimationDuration,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    double topOffset = 0;
    final RenderObject? object = context.findRenderObject();
    if (object?.parentData is ContainerBoxParentData) {
      // ignore: cast_nullable_to_non_nullable
      topOffset = (object!.parentData as ContainerBoxParentData).offset.dy;
    }

    listPadding = MediaQuery.of(context).size.height;

    _adjustedTopOffset = _currentScrollLocation - topOffset;
    _scrollController = ScrollController(
        initialScrollOffset: listPadding -
            _currentScrollLocation +
            topOffset +
            _currentList.getSelectedItemIndex() * _currentList.itemHeight());

    return Stack(
      children: <Widget>[
        _InheritedContainerListeners(
          listeners: this,
          child: widget.child,
        ),
        Visibility(
          visible: isOverlayVisible,
          child: FadeTransition(
            opacity: fadeAnimationController
                .drive(CurveTween(curve: Curves.easeOut)),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      _getListWidget(),
                      _getSelectionOverlayWidget(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _getListWidget() {
    var paddingLeft = 0.0;

    if (_currentList.items.isNotEmpty) {
      final Rect? rect = RectGetter.getRectFromKey(
          _currentList.paddingItemController.paddingGlobalKey);
      if (rect != null) {
        paddingLeft = rect.left;
      }
    }

    final Decoration dslContainerDecoration = widget.decoration ??
        BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor);

    return Container(
        decoration: dslContainerDecoration,
        child: ListView.builder(
          padding: EdgeInsets.only(left: paddingLeft),
          controller: _scrollController,
          itemCount: _currentList.items.length + 2,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0 || index == _currentList.items.length + 1) {
              return Container(height: listPadding);
            }
            final item = _currentList.items[index - 1];
            final normalScale = 1.0;
            if (lastSelectedItem == index - 1) {
              item.updateScale(_calculateNewScale(normalScale));
            } else {
              item.updateScale(normalScale);
            }
            return item;
          },
        ));
  }

  Widget _getSelectionOverlayWidget() {
    return Positioned(
        top: _adjustedTopOffset,
        left: 0,
        right: 0,
        height: _currentList.itemHeight(),
        child: Container(
            height: _currentList.itemHeight(),
            decoration: _currentList.focusedItemDecoration != null
                ? _currentList.focusedItemDecoration
                : BoxDecoration()));
  }

  double _allowedDragDistance(double currentScrollOffset, double position) {
    final double newPosition = currentScrollOffset + position;
    final double endOfListPosition =
        (_currentList.items.length - 1) * _currentList.itemHeight() +
            listPadding;
    if (newPosition < listPadding) {
      return listPadding - currentScrollOffset;
    } else if (newPosition > endOfListPosition) {
      return endOfListPosition - currentScrollOffset;
    } else {
      return position;
    }
  }

  void _performScaleTransformation(double scrollPixels, int selectedItemIndex) {
    final neighbourDistance = _getNeighbourListElementDistance(scrollPixels);
    final int neighbourIncrementDirection =
        neighbourScrollDirection(neighbourDistance);

    final int neighbourIndex = lastSelectedItem + neighbourIncrementDirection;

    final double neighbourDistanceToCurrentItem =
        _getNeighbourListElementDistanceToCurrentItem(neighbourDistance);

    if (neighbourIndex < 0 || neighbourIndex > _currentList.items.length - 1) {
      //incorrect neighbour index quit
      return;
    }
    _currentList.items[selectedItemIndex].updateOpacity(1);
    _currentList.items[neighbourIndex].updateOpacity(0.5);

    _currentList.items[selectedItemIndex]
        .updateScale(_calculateNewScale(neighbourDistanceToCurrentItem));
    _currentList.items[neighbourIndex]
        .updateScale(_calculateNewScale(neighbourDistance.abs()));
  }

  double _calculateNewScale(double distance) =>
      1.0 + distance / _currentList.items[lastSelectedItem].scaleFactor;

  int neighbourScrollDirection(double neighbourDistance) {
    int neighbourScrollDirection = 0;
    if (neighbourDistance > 0) {
      neighbourScrollDirection = 1;
    } else {
      neighbourScrollDirection = -1;
    }
    return neighbourScrollDirection;
  }

  double _getNeighbourListElementDistanceToCurrentItem(
      double neighbourDistance) {
    double neighbourDistanceToCurrentItem = 1 - neighbourDistance.abs();

    if (neighbourDistanceToCurrentItem > 1 ||
        neighbourDistanceToCurrentItem < 0) {
      neighbourDistanceToCurrentItem = 1.0;
    }
    return neighbourDistanceToCurrentItem;
  }

  int _getCurrentListElementIndex(double scrollPixels) {
    int selectedElement = (scrollPixels / _currentList.itemHeight()).round();
    final maxElementIndex = _currentList.items.length;

    if (selectedElement < 0) {
      selectedElement = 0;
    }
    if (selectedElement >= maxElementIndex) {
      selectedElement = maxElementIndex - 1;
    }
    return selectedElement;
  }

  double _getNeighbourListElementDistance(double scrollPixels) {
    final double selectedElementDeviation =
        scrollPixels / _currentList.itemHeight();
    final int selectedElement = _getCurrentListElementIndex(scrollPixels);
    return selectedElementDeviation - selectedElement;
  }

  Future toggleListOverlayVisibility(
      DropdownTransitionList visibleList, double location) async {
    if (isOverlayVisible) {
      try {
        await _scrollController.animateTo(
          listPadding -
              _adjustedTopOffset +
              lastSelectedItem * _currentList.itemHeight(),
          duration: scrollToListElementAnimationDuration,
          curve: Curves.ease,
        );
      } on Exception catch (_) {
      } finally {
        _currentList.setSelectedItemIndex(lastSelectedItem);
        await Future.delayed(Duration(milliseconds: 200));
        await fadeAnimationController.reverse();
        setState(_hideListOverlay);
      }
    } else {
      setState(() {
        _showListOverlay(visibleList, location);
      });
    }
  }

  Future<void> _showListOverlay(
      DropdownTransitionList visibleList, double location) async {
    _currentList = visibleList;
    _currentScrollLocation = location;
    lastSelectedItem = _currentList.getSelectedItemIndex();
    _currentList.items[lastSelectedItem].updateOpacity(1);
    isOverlayVisible = true;
    await fadeAnimationController.forward(from: 0);
  }

  void _hideListOverlay() {
    _scrollController.dispose();
    _currentList.items[lastSelectedItem].updateScale(1);
    _currentScrollLocation = 0;
    _adjustedTopOffset = 0;
    isOverlayVisible = false;
  }

  @override
  void performListDrag(double dragDy) {
    try {
      if (_scrollController.hasClients) {
        final currentScrollOffset = _scrollController.offset;
        final double allowedOffset = _allowedDragDistance(
            currentScrollOffset + _adjustedTopOffset,
            dragDy * widget.dragSpeedMultiplier);
        if (allowedOffset != 0.0) {
          _scrollController.jumpTo(currentScrollOffset + allowedOffset);

          final scrollPixels =
              _scrollController.offset - listPadding + _adjustedTopOffset;
          final selectedItemIndex = _getCurrentListElementIndex(scrollPixels);
          lastSelectedItem = selectedItemIndex;

          _performScaleTransformation(scrollPixels, selectedItemIndex);
        }
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}

class DropdownTransitionGestureEventListeners {
  Future toggleListOverlayVisibility(
          DropdownTransitionList list, double location) =>
      throw Exception('Not implemented.');

  void performListDrag(double dragDy) => throw Exception('Not implemented');
}

/// Allows Direct Select List implementations to
class _InheritedContainerListeners extends InheritedWidget {
  _InheritedContainerListeners({
    Key? key,
    required this.listeners,
    required Widget child,
  }) : super(key: key, child: child);

  final DropdownTransitionGestureEventListeners listeners;

  @override
  bool updateShouldNotify(_InheritedContainerListeners old) =>
      old.listeners != listeners;
}
