import 'package:cores/utils/validate_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_fm/shared/localizations/l10n/localy.dart';
import 'package:flutter_fm/shared/validation/validation_result.dart';

class LoginScreenValidationResults {
  LoginScreenValidationResults(BuildContext context) {
    this.context = context;
  }

  late BuildContext context;

  ValidationResult validateEmail(String email) {
    if (ValidateUtils.isNullEmptyOrWhitespace(email)) {
      return ValidationResult.error(
        Localy.of(context)!.loginScreenLabelEmailErrorMessage,
      );
    } else if (!ValidateUtils.validateEmail(email)) {
      return ValidationResult.error(
        Localy.of(context)!.loginScreenLabelEmailTypeErrorMessage,
      );
    }
    return ValidationResult.ok();
  }

  ValidationResult validatePassword(String password) {
    if (ValidateUtils.isNullEmptyOrWhitespace(password)) {
      return ValidationResult.error(
        Localy.of(context)!.loginScreenLabelPasswordErrorMessage,
      );
    }
    if (password.length < 6) {
      return ValidationResult.error(
        Localy.of(context)!.loginScreenLabelPasswordLengthErrorMessage,
      );
    }
    return ValidationResult.ok();
  }

  bool validateForm({required String email, required String password}) {
    final emailValid = validateEmail(email).isValid;
    final passwordValid = validatePassword(password).isValid;

    return emailValid && passwordValid;
  }
}
