import 'package:cores/helpers/safe_get/safe_get.dart';

extension NullableListSafeGet on SafeGet {
  List<T> _parse<T>(
    T Function(RequiredSafeGet) map, {
    T Function(SafeGet safeGet)? whenNull,
  }) {
    final value = required().value;
    if (value is List) {
      final result = <T>[];
      var index = -1;
      for (final item in value) {
        index++;
        if (item != null) {
          final picked =
              RequiredSafeGet(item, path: [...path, index], context: context);
          result.add(map(picked));
          continue;
        }
        if (whenNull == null) {
          // skip null items when whenNull isn't provided
          continue;
        }
        try {
          final safeGet =
              SafeGet(null, path: [...path, index], context: context);
          result.add(whenNull(safeGet));
          continue;
        } on Exception catch (_) {
          // ignore: avoid_print
          print(
            'whenNull at location $debugParsingExit index: $index '
            'crashed instead of returning a $T',
          );
          rethrow;
        }
      }
      return result;
    }
    throw SafeGetException(
      'Type ${value.runtimeType} of $debugParsingExit '
      'can not be casted to List<dynamic>',
    );
  }

  List<T> asListOrThrow<T>(
    T Function(RequiredSafeGet) map, {
    T Function(SafeGet safeGet)? whenNull,
  }) {
    withContext(
      requiredSafeGetErrorHintKey,
      'Use asListOrEmpty()/asListOrNull() when the value may be null/absent at some point (List<$T>?).',
    );
    return _parse(map, whenNull: whenNull);
  }

  List<T> asListOrEmpty<T>(
    T Function(RequiredSafeGet) map, {
    T Function(SafeGet safeGet)? whenNull,
  }) {
    if (value == null) {
      return <T>[];
    }
    if (value is! List) {
      return <T>[];
    }
    return _parse(map, whenNull: whenNull);
  }

  List<T>? asListOrNull<T>(
    T Function(RequiredSafeGet) map, {
    T Function(SafeGet safeGet)? whenNull,
  }) {
    if (value == null) {
      return null;
    }
    if (value is! List) {
      return null;
    }
    return _parse(map, whenNull: whenNull);
  }
}
