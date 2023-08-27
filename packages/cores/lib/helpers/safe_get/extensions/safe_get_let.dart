import 'package:cores/helpers/safe_get/safe_get.dart';

extension Let on RequiredSafeGet {
  R let<R>(R Function(RequiredSafeGet pick) block) {
    return block(this);
  }
}

extension NullableLet on SafeGet {
  R letOrThrow<R>(R Function(RequiredSafeGet pick) block) {
    withContext(
      requiredSafeGetErrorHintKey,
      'Use letOrNull() when the value may be null/absent at some point.',
    );
    return block(required());
  }

  R? letOrNull<R>(R Function(RequiredSafeGet safeGet) block) {
    if (value == null) {
      return null;
    }
    return block(required());
  }
}
