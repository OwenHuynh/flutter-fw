import 'package:components/res/res.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class KeyboardUtil {
  static KeyboardActionsConfig getKeyboardActionsConfig(
      BuildContext context, List<FocusNode> list, String? action) {
    return KeyboardActionsConfig(
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: List.generate(
          list.length,
          (i) => KeyboardActionsItem(
                focusNode: list[i],
                toolbarButtons: [
                  (node) {
                    return GestureDetector(
                      onTap: () => node.unfocus(),
                      child: Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Text(action ?? AppStrings.closeLabelCommon),
                      ),
                    );
                  },
                ],
              )),
    );
  }
}
