/// Enum representing the type of log messages.
///
/// This enum is used to categorize log messages into different types,
/// which can be useful for applying different formatting or handling
/// strategies for each type of log message.
enum LogType {
  /// Informational messages that represent the normal operation of the system.
  info,

  /// Initialization messages that are logged when the system or a component is being initialized.
  init,

  /// Error messages that represent issues or problems that need attention.
  error,
}