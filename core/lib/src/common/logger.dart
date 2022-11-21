import 'dart:developer' as develop show log;

// ignore: avoid_classes_with_only_static_members
class Logger {
  static void error(Object? error, [StackTrace? stack]) {
    final len = error.toString().length + 4;
    develop.log('-' * len, error: error, stackTrace: stack);
  }
}
