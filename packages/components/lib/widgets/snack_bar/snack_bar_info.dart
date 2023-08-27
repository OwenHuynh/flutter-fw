import 'package:components/res/res.dart';
import 'package:flutter/material.dart';

class SnackBarInfo extends SnackBar {
  SnackBarInfo(this.title, this.scaffoldMessengerState, this.backgroundColor,
      {Key? key})
      : super(
          key: key,
          content: Row(
            children: [
              Expanded(child: Text(title, textAlign: TextAlign.center)),
              InkWell(
                onTap: scaffoldMessengerState.hideCurrentSnackBar,
                child: const Icon(Icons.close, color: AppColors.white),
              ),
            ],
          ),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(RadiusAlias.Radius8),
          ),
          backgroundColor: backgroundColor,
        );

  final String title;
  final ScaffoldMessengerState scaffoldMessengerState;
  final Color? backgroundColor;

  void show() => scaffoldMessengerState.showSnackBar(this);
}
