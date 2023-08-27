import 'package:components/res/res.dart';
import 'package:components/utils/utils.dart';
import 'package:flutter/material.dart';

class FlatButtonOutlinedComponent extends StatelessWidget {
  const FlatButtonOutlinedComponent(
      {Key? key,
      required this.title,
      required this.onPressed,
      this.unFocusInput = false})
      : super(key: key);

  final String title;
  final VoidCallback? onPressed;
  final bool unFocusInput;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: MaterialButton(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          color: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: AppColors.primary),
          ),
          onPressed: () {
            if (DebounceClickAction.isMultiClick()) {
              return;
            }

            if (onPressed != null) {
              if (unFocusInput) {
                Future.microtask(() {
                  return FocusScope.of(context).requestFocus(new FocusNode());
                });
              }
              onPressed!();
            }
          },
          child: Text(title, style: Theme.of(context).textTheme.buttonPrimary)),
    );
  }
}
