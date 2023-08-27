import 'package:components/res/res.dart';
import 'package:components/utils/utils.dart';
import 'package:flutter/material.dart';

class FlatButtonComponent extends StatelessWidget {
  const FlatButtonComponent(
      {Key? key,
      required this.title,
      required this.onPressed,
      this.enabled = true,
      this.unFocusInput = false})
      : super(key: key);

  final String title;
  final VoidCallback? onPressed;
  final bool enabled;
  final bool unFocusInput;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        color: AppColors.primary,
        disabledTextColor: AppColors.grey1,
        disabledColor: AppColors.lightGrey19,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: () {
          if (DebounceClickAction.isMultiClick()) {
            return;
          }

          if (enabled && onPressed != null) {
            if (unFocusInput) {
              Future.microtask(() {
                return FocusScope.of(context).requestFocus(new FocusNode());
              });
            }
            onPressed!();
          }
        },
        child: Text(title, style: Theme.of(context).textTheme.buttonWhite),
      ),
    );
  }
}
