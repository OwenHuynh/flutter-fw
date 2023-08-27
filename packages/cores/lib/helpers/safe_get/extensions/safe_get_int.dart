import 'package:cores/helpers/safe_get/safe_get.dart';

extension NullableIntSafeGet on SafeGet {
  int _parse(bool roundDouble, bool truncateDouble) {
    final value = required().value;
    if (roundDouble && truncateDouble) {
      throw SafeGetException(
        '[roundDouble] and [truncateDouble] can not be true at the same time',
      );
    }
    if (value is int) {
      return value;
    }
    if (value is num && roundDouble) {
      return value.round();
    }
    if (value is num && truncateDouble) {
      return value.toInt();
    }
    if (value is String) {
      final parsed = int.tryParse(value);
      if (parsed != null) {
        return parsed;
      }
    }

    throw SafeGetException(
      'Type ${value.runtimeType} of $debugParsingExit '
      'can not be parsed as int, set [roundDouble] '
      'or [truncateDouble] to parse from double',
    );
  }

  int asIntOrThrow({bool roundDouble = false, bool truncateDouble = false}) {
    withContext(
      requiredSafeGetErrorHintKey,
      'Use asIntOrNull() when the value may be null/absent at some point (int?).',
    );
    return _parse(roundDouble, truncateDouble);
  }

  int? asIntOrNull({bool roundDouble = false, bool truncateDouble = false}) {
    if (value == null) {
      return null;
    }
    try {
      return _parse(roundDouble, truncateDouble);
    } on Exception catch (_) {
      return null;
    }
  }
}
