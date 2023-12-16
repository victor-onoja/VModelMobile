import 'dart:developer' as developer;

class AppLogger {
  static const String _defaultTag = 'AppLogger';

  final String tag;

  AppLogger([this.tag = _defaultTag]);

  void d(String message) {
    developer.log(message, name: tag, level: 0, time: DateTime.now());
  }

  void i(String message) {
    developer.log(message, name: tag, level: 1, time: DateTime.now());
  }

  void w(String message) {
    developer.log(message, name: tag, level: 2, time: DateTime.now());
  }

  void e(String message, [dynamic error]) {
    developer.log(message,
        name: tag, error: error, level: 3, time: DateTime.now());
  }
}



// final logger = AppLogger('MyApp');

// logger.d('Debug message');
// logger.i('Info message');
// logger.w('Warning message');
// logger.e('Error message', Exception('Something went wrong'));
