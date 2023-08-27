import 'package:cores/helpers/safe_get/safe_get.dart';

extension NullableMapSafeGet on SafeGet {
  Map<RK, RV> _parse<RK, RV>() {
    final value = required().value;
    if (value is Map) {
      final view = value.cast<RK, RV>();
      return Map.of(view);
    }
    throw SafeGetException(
      'Type ${value.runtimeType} of $debugParsingExit '
      'can not be casted to Map<dynamic, dynamic>',
    );
  }

  Map<RK, RV> asMapOrThrow<RK, RV>() {
    withContext(
      requiredSafeGetErrorHintKey,
      'Use asMapOrEmpty()/asMapOrNull() when '
      'the value may be null/absent at some point (Map<$RK, $RV>?).',
    );
    return _parse();
  }

  Map<RK, RV> asMapOrEmpty<RK, RV>() {
    if (value == null) {
      return <RK, RV>{};
    }
    if (value is! Map) {
      return <RK, RV>{};
    }
    return _parse();
  }

  Map<RK, RV>? asMapOrNull<RK, RV>() {
    if (value == null) {
      return null;
    }
    if (value is! Map) {
      return null;
    }
    return _parse();
  }
}
