import 'package:logger/logger.dart';

class AppLog {
  static Logger logger = Logger(
    printer: PrettyPrinter(
        methodCount: 2, // number of method calls to be displayed
        errorMethodCount: 8, // number of method calls if stacktrace is provided
        lineLength: 120, // width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        printTime: false // Should each log print contain a timestamp
        ),
  );

  static debug(message) {
    logger.d(message);
  }

  static info(message) {
    logger.i(message);
  }

  static warn(message) {
    logger.w(message);
  }

  static error(message) {
    logger.e(message);
  }

  static wtf(message) {
    logger.wtf(message);
  }
}
