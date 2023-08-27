import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fm/shared/localizations/l10n/localy.dart';

class UIUtils {
  static void showPopupWindow(BuildContext context,
      {required String text, required GlobalKey popKey}) {
    PopupWindowComponent.showPopWindow(context, text, popKey,
        popDirection: PopupDirection.top, hasCloseIcon: true);
  }

  static void showLoading(BuildContext context,
      {bool tapOutsideDismiss = true}) {
    LoadingDialog.show(context, barrierDismissible: tapOutsideDismiss);
  }

  static void hideLoading(BuildContext context) {
    LoadingDialog.dismiss(context);
  }

  static void showSuccessMessage(BuildContext context, String message) {
    SnackBarInfo(message, ScaffoldMessenger.of(context), AppColors.success)
        .show();
  }

  static void showWarningMessage(BuildContext context, String message) {
    SnackBarInfo(message, ScaffoldMessenger.of(context), AppColors.warning)
        .show();
  }

  static void showErrorMessage(BuildContext context, String message) {
    SnackBarInfo(message, ScaffoldMessenger.of(context), AppColors.error)
        .show();
  }

  static void showInfoMessage(BuildContext context, String message) {
    SnackBarInfo(message, ScaffoldMessenger.of(context), AppColors.info).show();
  }

  static void showConfirmDialog(
      {required BuildContext context,
      required String title,
      required String message,
      required GestureTapCallback buttonConfirmCallback,
      required GestureTapCallback onCancel}) {
    DialogManager.showConfirmDialog(context,
        title: title,
        message: message,
        dialogStyle: BaseDialogStyle(
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold, fontSize: FontAlias.fontAlias16)),
        cancel: Localy.of(context)!.commonCancel,
        confirm: Localy.of(context)!.commonOk,
        onConfirm: buttonConfirmCallback,
        onCancel: onCancel);
  }
}
