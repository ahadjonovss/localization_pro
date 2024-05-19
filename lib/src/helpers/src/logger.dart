/// A simple logger class that provides logging capabilities depending on the debug mode.
class Logger {
  /// Indicates whether logging is enabled.
  final bool debugMode;

  /// Constructs a logger where logging can be enabled or disabled.
  Logger({required this.debugMode});

  /// Logs a message to the console if debug mode is enabled.
  void log(String message) {
    if (debugMode) {
      print("LocalizationManager: $message");
    }
  }
}
