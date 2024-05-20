import 'package:localization_pro/src/utils/enums/src/log_type.dart';

/// A simple logger class that provides logging capabilities depending on the debug mode.
///
/// The `Logger` class is used to print log messages to the console. It supports
/// different types of log messages, each displayed in a different color to
/// distinguish between informational messages, initialization messages, and error messages.
class Logger {
  /// Indicates whether logging is enabled.
  final bool debugMode;

  /// Constructs a logger where logging can be enabled or disabled.
  ///
  /// The [debugMode] parameter specifies whether logging is enabled.
  Logger({required this.debugMode});

  /// Logs a message to the console if debug mode is enabled.
  ///
  /// The [message] parameter is the log message to be printed.
  /// The optional [type] parameter specifies the type of log message and defaults to [LogType.info].
  void log(String message, {LogType type = LogType.info}) {
    if (debugMode) {
      String colorCode;
      switch (type) {
        case LogType.init:
          colorCode = '\x1B[32m'; // Green
          break;
        case LogType.error:
          colorCode = '\x1B[31m'; // Red
          break;
        case LogType.info:
        default:
          colorCode = '\x1B[34m'; // Blue
          break;
      }
      // Reset color
      String resetCode = '\x1B[0m';
      print('$colorCode$message$resetCode');
    }
  }
}
