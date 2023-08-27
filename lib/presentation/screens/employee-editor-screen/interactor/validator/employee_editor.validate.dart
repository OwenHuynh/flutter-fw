import 'package:cores/utils/validate_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_fm/shared/localizations/l10n/localy.dart';
import 'package:flutter_fm/shared/validation/validation_result.dart';

class EmployeeEditorValidationResults {
  EmployeeEditorValidationResults(BuildContext context) {
    this.context = context;
  }

  late BuildContext context;

  ValidationResult validateName(String name) {
    if (ValidateUtils.isNullEmptyOrWhitespace(name)) {
      return ValidationResult.error(Localy.of(context)!.textErrorName);
    }
    return ValidationResult.ok();
  }

  ValidationResult validateAge(String age) {
    if (ValidateUtils.isNullEmptyOrWhitespace(age.toString())) {
      return ValidationResult.error(Localy.of(context)!.textErrorAge);
    }
    return ValidationResult.ok();
  }

  ValidationResult validateEmail(String email) {
    if (ValidateUtils.isNullEmptyOrWhitespace(email)) {
      return ValidationResult.error(Localy.of(context)!.textErrorEmail);
    }
    if (!ValidateUtils.validateEmail(email.trim())) {
      return ValidationResult.error(
          Localy.of(context)!.loginScreenLabelEmailTypeErrorMessage);
    }
    return ValidationResult.ok();
  }

  bool validateForm(
      {required String name, required String email, required String age}) {
    final nameValid = validateName(name).isValid;
    final emailValid = validateEmail(email).isValid;
    final ageValid = validateAge(age).isValid;
    return nameValid && emailValid && ageValid;
  }
}
