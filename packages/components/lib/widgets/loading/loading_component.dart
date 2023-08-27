import 'package:components/res/res.dart';
import 'package:flutter/material.dart';

class LoadingComponent extends StatelessWidget {
  LoadingComponent({this.content});

  final String? content;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 50,
        width: 130,
        decoration: BoxDecoration(
            color: Color(0xff222222),
            border: null,
            borderRadius: BorderRadius.circular(RadiusAlias.Radius4)),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: SpacingAlias.Spacing8),
                child: Text(
                  content ?? AppStrings.loadingLabelCommon,
                  style: TextStyle(
                      fontSize: FontAlias.fontAlias14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      decoration: TextDecoration.none),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LoadingDialog extends Dialog {
  LoadingDialog({Key? key, this.content = "Loading..."}) : super(key: key);
  final String? content;

  @override
  Widget build(BuildContext context) {
    return LoadingComponent(content: content);
  }

  static void show(
    BuildContext context, {
    String? content,
    bool barrierDismissible = true,
    bool useRootNavigator = true,
  }) {
    showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        useRootNavigator: useRootNavigator,
        builder: (_) {
          return LoadingDialog(content: content);
        });
  }

  static void dismiss(BuildContext context) {
    Navigator.pop(context);
  }
}
