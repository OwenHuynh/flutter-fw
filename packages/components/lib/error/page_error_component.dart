import 'package:components/components.dart';
import 'package:components/res/image_alias.dart';
import 'package:flutter/material.dart';

class PageErrorComponent extends StatelessWidget {
  const PageErrorComponent(
      {this.errorMessage, this.buttonTitle, this.buttonOnPressed, Key? key})
      : super(key: key);
  final String? errorMessage;
  final String? buttonTitle;
  final VoidCallback? buttonOnPressed;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const SizedBox(height: SpacingAlias.Spacing24),
      Image.asset(ImageAlias.errorPage),
      const SizedBox(height: SpacingAlias.Spacing24),
      Expanded(
          child: Text(
        errorMessage ?? "",
        style: Theme.of(context)
            .textTheme
            .subtitle2!
            .copyWith(color: AppColors.error, fontSize: FontAlias.fontAlias14),
      )),
      if (buttonTitle != null && buttonOnPressed != null)
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: FlatButtonComponent(
              title: buttonTitle!, onPressed: buttonOnPressed),
        ),
    ]);
  }
}
