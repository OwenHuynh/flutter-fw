import 'package:components/widgets/dropdown/dropdown_transition/dropdown_transition_container.dart';
import 'package:components/widgets/dropdown/dropdown_transition/dropdown_transition_item.dart';
import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';

typedef DropdownTransitionItemsBuilder<T> = DropdownTransitionItem<T>? Function(
    T value);

class PaddingItemController {
  GlobalKey<RectGetterState> paddingGlobalKey = RectGetter.createGlobalKey();
}

typedef ItemSelected = Future<dynamic> Function(
    DropdownTransitionList owner, double location);

class DropdownTransitionList<T> extends StatefulWidget {
  DropdownTransitionList({
    Key? key,
    required List<T> values,
    required DropdownTransitionItemsBuilder<T> itemBuilder,
    this.onItemSelectedListener,
    this.focusedItemDecoration,
    this.defaultItemIndex = 0,
    this.onUserTappedListener,
  })  : items = values.map((val) => itemBuilder(val)).toNotNullableList(),
        selectedItem = ValueNotifier<int>(defaultItemIndex),
        assert(defaultItemIndex + 1 <= values.length + 1),
        super(key: key);

  ///Item widgets
  final List<DropdownTransitionItem<T>> items;

  ///Current focused item overlay
  final Decoration? focusedItemDecoration;

  ///Default selected item index
  final int defaultItemIndex;

  ///Notifies state about new item selected
  final ValueNotifier<int> selectedItem;

  ///Function to execute when item selected
  final Function(T value, int selectedIndex, BuildContext context)?
      onItemSelectedListener;

  ///Callback for action when user just tapped instead of hold and scroll
  final VoidCallback? onUserTappedListener;

  ///Holds [GlobalKey] for [RectGetter]
  final PaddingItemController paddingItemController = PaddingItemController();

  @override
  State<StatefulWidget> createState() {
    return DropdownTransitionState<T>();
  }

  // TODO(issue): pass item height in this class
  //  and build items with that height
  double itemHeight() {
    if (items.isNotEmpty) {
      return items.first.itemHeight;
    }
    return 0;
  }

  int getSelectedItemIndex() {
    return selectedItem.value;
  }

  void setSelectedItemIndex(int index) {
    if (index != selectedItem.value) {
      selectedItem.value = index;
    }
  }

  T getSelectedItem() {
    return items[selectedItem.value].value;
  }
}

class DropdownTransitionState<T> extends State<DropdownTransitionList<T>> {
  final GlobalKey<DropdownTransitionItemState> animatedStateKey =
      GlobalKey<DropdownTransitionItemState>();

  late Future Function(DropdownTransitionList, double) onTapEventListener;
  late void Function(double) onDragEventListener;

  bool isOverlayVisible = false;
  int? lastSelectedItem;

  bool _isShowUpAnimationRunning = false;

  Map<int, Widget> selectedItemWidgets = Map();

  @override
  void initState() {
    super.initState();
    lastSelectedItem = widget.defaultItemIndex;
    _updateSelectItemWidget();
  }

  @override
  void didUpdateWidget(DropdownTransitionList oldWidget) {
    widget.paddingItemController.paddingGlobalKey =
        oldWidget.paddingItemController.paddingGlobalKey;
    _updateSelectItemWidget();
    super.didUpdateWidget(widget);
  }

  void _updateSelectItemWidget() {
    selectedItemWidgets.clear();
    for (int index = 0; index < widget.items.length; index++) {
      selectedItemWidgets.putIfAbsent(
        index,
        () => widget.items[index].getSelectedItem(
          animatedStateKey,
          widget.paddingItemController.paddingGlobalKey,
        ),
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final dsListener = DropdownTransitionContainer.of(context);

    this.onTapEventListener = dsListener.toggleListOverlayVisibility;

    this.onDragEventListener = dsListener.performListDrag;
  }

  @override
  Widget build(BuildContext context) {
    widget.selectedItem.addListener(() {
      if (widget.onItemSelectedListener != null) {
        widget.onItemSelectedListener?.call(
            widget.items[widget.selectedItem.value].value,
            widget.selectedItem.value,
            this.context);
      }
    });

    bool transitionEnded = false;

    return ValueListenableBuilder<int>(
        valueListenable: widget.selectedItem,
        builder: (context, value, child) {
          final selectedItem = selectedItemWidgets[value];
          return GestureDetector(
              child: selectedItem,
              onTap: () {
                if (widget.onUserTappedListener != null) {
                  widget.onUserTappedListener?.call();
                }
              },
              onTapDown: (tapDownDetails) async {
                if (!isOverlayVisible) {
                  transitionEnded = false;
                  _isShowUpAnimationRunning = true;
                  await animatedStateKey.currentState
                      ?.runScaleTransition(reverse: false);
                  if (!transitionEnded) {
                    await _showListOverlay(_getItemTopPosition(context));
                    _isShowUpAnimationRunning = false;
                    lastSelectedItem = value;
                  }
                }
              },
              onTapUp: (tapUpDetails) async {
                await _hideListOverlay(_getItemTopPosition(context));
                await animatedStateKey.currentState
                    ?.runScaleTransition(reverse: true);
              },
              onVerticalDragEnd: (dragDetails) async {
                transitionEnded = true;
                await _dragEnd();
              },
              onHorizontalDragEnd: (horizontalDetails) async {
                transitionEnded = true;
                await _dragEnd();
              },
              onVerticalDragUpdate: (dragInfo) {
                if (!_isShowUpAnimationRunning) {
                  _showListOverlay(dragInfo.primaryDelta);
                }
              });
        });
  }

  Future<void> _dragEnd() async {
    await _hideListOverlay(_getItemTopPosition(context));
    await animatedStateKey.currentState?.runScaleTransition(reverse: true);
  }

  double _getItemTopPosition(BuildContext context) {
    // ignore: cast_nullable_to_non_nullable
    final RenderBox itemBox = context.findRenderObject() as RenderBox;
    final Rect itemRect = itemBox.localToGlobal(Offset.zero) & itemBox.size;
    return itemRect.top;
  }

  Future<void> _hideListOverlay(double dy) async {
    if (isOverlayVisible) {
      isOverlayVisible = false;
      // TODO(issue): fix to prevent stuck scale
      //  if selected item is the same as previous
      await onTapEventListener(widget, dy);
      if (lastSelectedItem == widget.selectedItem.value) {
        await animatedStateKey.currentState?.runScaleTransition(reverse: true);
      }
    }
  }

  Future<void> _showListOverlay(double? dy) async {
    if (!isOverlayVisible) {
      isOverlayVisible = true;
      await onTapEventListener(widget, _getItemTopPosition(context));
    } else if (dy != null) {
      onDragEventListener(dy);
    }
  }
}

extension _ListHelper on Iterable {
  List<T> toNotNullableList<T>() {
    final data = this.toList();
    return data.contains(null) ? List<T>.empty() : data.cast<T>();
  }
}
