import 'package:components/res/image_alias.dart';
import 'package:components/res/res.dart';
import 'package:components/utils/image_util.dart';
import 'package:flutter/material.dart';

typedef OnSearchTextChange = void Function(String content);

typedef OnSearchCommit = void Function(String content);

typedef OnSearchTextClear = bool Function();

class SearchInputText extends StatefulWidget {
  const SearchInputText({
    Key? key,
    this.searchController,
    this.controller,
    this.maxLines = 1,
    this.maxLength,
    this.hintText,
    this.hintStyle,
    this.textStyle,
    this.prefixIcon,
    this.onTextChange,
    this.onTextCommit,
    this.onTextClear,
    this.onActionTap,
    this.action,
    this.maxHeight = 60,
    this.innerPadding =
        const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
    this.outSideColor = Colors.white,
    this.innerColor = const Color(0xfff8f8f8),
    this.normalBorder,
    this.activeBorder,
    this.borderRadius = const BorderRadius.all(const Radius.circular(6)),
    this.focusNode,
    this.autoFocus = false,
    this.textInputAction,
  }) : super(key: key);

  final String? hintText;

  final TextStyle? hintStyle;

  final TextStyle? textStyle;

  final Widget? prefixIcon;

  final Color? outSideColor;

  final Color? innerColor;

  final int? maxLines;

  final int? maxLength;

  final double? maxHeight;

  final EdgeInsets? innerPadding;

  final BoxBorder? normalBorder;

  final BoxBorder? activeBorder;

  final BorderRadius? borderRadius;

  final Widget? action;

  final bool? autoFocus;

  final TextInputAction? textInputAction;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final OnSearchTextChange? onTextChange;

  final OnSearchCommit? onTextCommit;

  final VoidCallback? onActionTap;

  final OnSearchTextClear? onTextClear;

  final SearchTextController? searchController;

  @override
  State<StatefulWidget> createState() {
    return _SearchTextState();
  }
}

class _SearchTextState extends State<SearchInputText> {
  FocusNode? focusNode;
  TextEditingController? textEditingController;
  BoxBorder? border;
  SearchTextController? searchTextController;

  SearchTextController? tmpController;

  @override
  void initState() {
    super.initState();

    if (widget.searchController == null) {
      tmpController = SearchTextController();
    }
    searchTextController = widget.searchController ?? tmpController;
    searchTextController?.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    focusNode = widget.focusNode ?? FocusNode();
    textEditingController = widget.controller ?? TextEditingController();
    border = widget.normalBorder ??
        Border.all(
          width: 1,
          color: widget.innerColor!,
        );

    focusNode?.addListener(_handleFocusNodeChangeListenerTick);
  }

  @override
  void dispose() {
    super.dispose();
    tmpController?.dispose();
    focusNode?.removeListener(_handleFocusNodeChangeListenerTick);
  }

  void _handleFocusNodeChangeListenerTick() {
    if (focusNode!.hasFocus) {
      border = widget.activeBorder ?? border;
    } else {
      border = widget.normalBorder ?? border;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: widget.maxHeight!,
      ),
      child: Container(
        padding: widget.innerPadding,
        color: widget.outSideColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: widget.innerColor,
                  border: border,
                  borderRadius: widget.borderRadius,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    widget.prefixIcon ??
                        Padding(
                          padding: const EdgeInsets.only(left: 14),
                          child: Center(
                            child: Container(
                                child: Image.asset(
                              'assets/${ImageAlias.searchIcon}',
                              height: 16,
                              width: 16,
                            )),
                          ),
                        ),
                    Expanded(
                      child: TextField(
                          maxLength: widget.maxLength,
                          autofocus: widget.autoFocus!,
                          textInputAction: this.widget.textInputAction,
                          focusNode: focusNode,
                          controller: textEditingController,
                          cursorColor: AppColors.colorLink,
                          cursorWidth: 2,
                          style: widget.textStyle ??
                              TextStyle(
                                  textBaseline: TextBaseline.alphabetic,
                                  color: AppColors.colorTextBase,
                                  fontSize: 16),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 8, right: 6),
                            fillColor: widget.innerColor,
                            isDense: true,
                            filled: true,
                            hintStyle: widget.hintStyle ??
                                TextStyle(
                                  fontSize: 16,
                                  height: 1,
                                  textBaseline: TextBaseline.alphabetic,
                                  color: Color(0xff999999),
                                ),
                            hintText: widget.hintText ?? "Search",
                            counterText: '',
                          ),
                          onChanged: (content) {
                            if (widget.onTextChange != null) {
                              widget.onTextChange!(content);
                            }
                            setState(() {});
                          },
                          onSubmitted: (content) {
                            if (widget.onTextCommit != null) {
                              widget.onTextCommit!(content);
                            }
                          }),
                    ),
                    Visibility(
                      visible: searchTextController!.isClearShow,
                      child: GestureDetector(
                        onTap: () {
                          if (widget.onTextClear != null) {
                            final bool isIntercept = widget.onTextClear!();
                            if (isIntercept) {
                              return;
                            }
                          }
                          textEditingController?.clear();
                          if (this.widget.onTextChange != null) {
                            this.widget.onTextChange!(
                                textEditingController!.value.text);
                          }
                          setState(() {});
                        },
                        child: Visibility(
                          visible: textEditingController!.text.isNotEmpty,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: ImageUtils.getAssetImage(
                              ImageAlias.deleteIcon,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Visibility(
              visible: searchTextController!.isActionShow,
              child: widget.action ??
                  GestureDetector(
                    onTap: () {
                      if (widget.onActionTap != null) {
                        widget.onActionTap!();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Text(
                        'Clear',
                        style: TextStyle(
                            color: AppColors.colorTextBase,
                            fontSize: 16,
                            height: 1),
                      ),
                    ),
                  ),
            )
          ],
        ),
      ),
    );
  }
}

class SearchTextController extends ChangeNotifier {
  bool _isClearShow = true;
  bool _isActionShow = false;

  bool get isClearShow => _isClearShow;

  bool get isActionShow => _isActionShow;

  set isClearShow(bool value) {
    _isClearShow = value;
    notifyListeners();
  }

  set isActionShow(bool value) {
    _isActionShow = value;
    notifyListeners();
  }
}
