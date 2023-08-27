import 'package:cores/helpers/safe_get/safe_get.dart';

extension RequiredStringSafeGet on RequiredSafeGet {
  String asString() => _parse();
}

extension NullableStringSafeGet on SafeGet {
  String _parse() {
    final value = required().value;
    if (value is String) {
      return value;
    }
    return value.toString();
  }

  String asStringOrThrow() {
    withContext(
      requiredSafeGetErrorHintKey,
      'Use asStringOrNull() when the value may be null/absent at some point (String?).',
    );
    return _parse();
  }

  String? asStringOrNull() {
    if (value == null) {
      return null;
    }
    try {
      return _parse();
    } on Exception catch (_) {
      return null;
    }
  }
}
