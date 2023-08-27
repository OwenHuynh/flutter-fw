import 'package:cores/helpers/safe_get/safe_get.dart';

extension BoolSafeGet on SafeGet {
  bool _parse() {
    final value = required().value;
    if (value is bool) {
      return value;
    }
    if (value is String) {
      if (value == 'true') {
        return true;
      }
      if (value == 'false') {
        return false;
      }
    }
    throw SafeGetException(
      'Type ${value.runtimeType} of $debugParsingExit'
      ' can not be casted to bool',
    );
  }

  bool asBoolOrThrow() {
    withContext(
      requiredSafeGetErrorHintKey,
      'Use asBoolOrNull() when the value '
      'may be null/absent at some point (bool?).',
    );
    return _parse();
  }

  bool? asBoolOrNull() {
    if (value == null) {
      return null;
    }
    try {
      return _parse();
    } on Exception catch (_) {
      return null;
    }
  }

  bool asBoolOrTrue() {
    if (value == null) {
      return true;
    }
    try {
      return _parse();
    } on Exception catch (_) {
      return true;
    }
  }

  bool asBoolOrFalse() {
    if (value == null) {
      return false;
    }
    try {
      return _parse();
    } on Exception catch (_) {
      return false;
    }
  }
}
