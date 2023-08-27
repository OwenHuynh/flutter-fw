import 'dart:convert';

SafeGet safeGetFromJson(
  String json, [
  Object? arg0,
  Object? arg1,
  Object? arg2,
  Object? arg3,
  Object? arg4,
  Object? arg5,
  Object? arg6,
  Object? arg7,
  Object? arg8,
  Object? arg9,
]) {
  final parsed = jsonDecode(json);
  return safeGet(
    parsed,
    arg0,
    arg1,
    arg2,
    arg3,
    arg4,
    arg5,
    arg6,
    arg7,
    arg8,
    arg9,
  );
}

SafeGet safeGet(
  /*Map|List|null*/ dynamic json, [
  /*String|int|null*/ Object? arg0,
  /*String|int|null*/ Object? arg1,
  /*String|int|null*/ Object? arg2,
  /*String|int|null*/ Object? arg3,
  /*String|int|null*/ Object? arg4,
  /*String|int|null*/ Object? arg5,
  /*String|int|null*/ Object? arg6,
  /*String|int|null*/ Object? arg7,
  /*String|int|null*/ Object? arg8,
  /*String|int|null*/ Object? arg9,
]) {
  final selectors = [arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9]
      // null is a sign for unused 'varargs'
      .where((dynamic it) => it != null)
      .cast<Object>()
      .toList(growable: false);
  return _drillDown(json, selectors);
}

SafeGet safeGetDeep(
  /*Map|List|null*/ dynamic json,
  List< /*String|int*/ Object> selector,
) {
  return _drillDown(json, selector);
}

SafeGet _drillDown(
  /*Map|List|null*/ dynamic json,
  List< /*String|int*/ Object> selectors, {
  List< /*String|int*/ Object> parentPath = const [],
  Map<String, dynamic>? context,
}) {
  final fullPath = [...parentPath, ...selectors];
  final path = <dynamic>[];
  /*Map|List|null*/
  dynamic data = json;
  for (final selector in selectors) {
    path.add(selector);
    if (data is List) {
      if (selector is int) {
        try {
          data = data[selector];
          if (data == null) {
            return SafeGet(null, path: fullPath, context: context);
          }
          // found a value, continue drill down
          continue;
          // ignore: avoid_catching_errors
        } on RangeError catch (_) {
          // out of range, value not found at index selector
          return SafeGet.absent(path.length - 1,
              path: fullPath, context: context);
        }
      }
    }
    if (data is Map) {
      if (!data.containsKey(selector)) {
        return SafeGet.absent(path.length - 1,
            path: fullPath, context: context);
      }
      final dynamic safeGeted = data[selector];
      if (safeGeted == null) {
        // no value mapped to selector
        return SafeGet(null, path: fullPath, context: context);
      }
      data = safeGeted;
      continue;
    }
    if (data is Set && selector is int) {
      throw SafeGetException(
        'Value at location ${path.sublist(0, path.length - 1)}'
        ' is a Set, which is a unordered data structure. '
        "It's not possible to SafeGet a value by using a index ($selector)",
      );
    }
    // can't drill down any more to find the exact location.
    return SafeGet.absent(path.length - 1, path: fullPath, context: context);
  }
  return SafeGet(data, path: fullPath, context: context);
}

class SafeGet {
  SafeGet(
    this.value, {
    this.path = const [],
    Map<String, dynamic>? context,
  }) : context = context != null ? Map.of(context) : {};

  SafeGet.absent(
    int missingValueAtIndex, {
    this.path = const [],
    Map<String, Object?>? context,
  })  : value = null,
        _missingValueAtIndex = missingValueAtIndex,
        context = context != null ? Map.of(context) : {};

  final Object? value;

  bool get isAbsent => missingValueAtIndex != null;
  final Map<String, dynamic> context;

  int? get index {
    final lastPathSegment = path.isNotEmpty ? path.last : null;
    if (lastPathSegment == null) {
      return null;
    }
    if (lastPathSegment is int) {
      // within a List
      return lastPathSegment;
    }
    return null;
  }

  int? get missingValueAtIndex => _missingValueAtIndex;
  int? _missingValueAtIndex;

  final List<Object> path;

  List<Object> get followablePath =>
      path.take(_missingValueAtIndex ?? path.length).toList();

  SafeGet call([
    Object? arg0,
    Object? arg1,
    Object? arg2,
    Object? arg3,
    Object? arg4,
    Object? arg5,
    Object? arg6,
    Object? arg7,
    Object? arg8,
    Object? arg9,
  ]) {
    final selectors =
        [arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9]
            // null is a sign for unused 'varargs'
            .where((Object? it) => it != null)
            .cast<Object>()
            .toList(growable: false);

    return _drillDown(value, selectors, parentPath: path, context: context);
  }

  RequiredSafeGet required() {
    final value = this.value;
    if (value == null) {
      final more = fromContext(requiredSafeGetErrorHintKey).value as String?;
      final moreSegment = more == null ? '' : ' $more';
      throw SafeGetException(
        'Expected a non-null value but location $debugParsingExit '
        'is ${isAbsent ? 'absent' : 'null'}.$moreSegment',
      );
    }
    return RequiredSafeGet(value, path: path, context: context);
  }

  @override
  @Deprecated('Use asStringOrNull() to SafeGet a String value')
  String toString() => 'SafeGet(value=$value, path=$path)';

  // ignore: avoid_returning_this
  SafeGet withContext(String key, Object? value) {
    context[key] = value;
    return this;
  }

  SafeGet fromContext(
    String key, [
    Object? arg0,
    Object? arg1,
    Object? arg2,
    Object? arg3,
    Object? arg4,
    Object? arg5,
    Object? arg6,
    Object? arg7,
    Object? arg8,
  ]) {
    return safeGet(
      context,
      key,
      arg0,
      arg1,
      arg2,
      arg3,
      arg4,
      arg5,
      arg6,
      arg7,
      arg8,
    );
  }

  String get debugParsingExit {
    final access = <String>[];

    final fullPath = path;
    final followable = followablePath;

    final foundValue = followable.length == fullPath.length;
    var foundNullPart = false;
    for (var i = 0; i < fullPath.length; i++) {
      final full = fullPath[i];
      final part = followable.length > i ? followable[i] : null;
      final nullPart = () {
        if (foundNullPart) {
          return '';
        }
        if (foundValue && i + 1 == fullPath.length) {
          if (value == null) {
            foundNullPart = true;
            return ' (null)';
          } else {
            return '($value)';
          }
        }
        if (part == null) {
          foundNullPart = true;
          return ' (absent)';
        }
        return '';
      }();

      if (full is int) {
        access.add('$full$nullPart');
      } else {
        access.add('"$full"$nullPart');
      }
    }

    var valueOrExit = '';
    if (foundValue) {
      valueOrExit = 'SafeGeted value "$value" using';
    } else {
      final firstMissing = fullPath.isEmpty
          ? '<root>'
          : fullPath[followable.isEmpty ? 0 : followable.length];
      final formattedMissing =
          firstMissing is int ? 'list index $firstMissing' : '"$firstMissing"';
      valueOrExit = '$formattedMissing in';
    }

    final params = access.isNotEmpty ? ', ${access.join(', ')}' : '';
    final root = access.isEmpty ? '<root>' : 'json';
    return '$valueOrExit SafeGet($root$params)';
  }
}

class RequiredSafeGet extends SafeGet {
  RequiredSafeGet(
    // using dynamic here to match the return type of jsonDecode
    dynamic value, {
    List<Object> path = const [],
    Map<String, Object?>? context,
  })  : value = value as Object,
        super(value, path: path, context: context);

  @override
  // ignore: overridden_fields
  covariant Object value;

  @override
  @Deprecated('Use asStringOrNull() to SafeGet a String value')
  String toString() => 'RequiredSafeGet(value=$value, path=$path)';

  SafeGet nullable() => SafeGet(value, path: path, context: context);

  @override
  RequiredSafeGet withContext(String key, Object? value) {
    super.withContext(key, value);
    return this;
  }
}

const requiredSafeGetErrorHintKey = '_required_safe_get_error_hint';

class SafeGetException implements Exception {
  SafeGetException(this.message);

  final String message;

  @override
  String toString() {
    return 'SafeGetException($message)';
  }
}
