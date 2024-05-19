/// Exports extensions for `BuildContext`.
///
/// These extensions provide convenient access to localization functionalities,
/// enabling widgets to dynamically manage translations and locales through the `BuildContext`.
/// This simplifies interaction with the `LocalizationManager` for operations like changing
/// locales or adding/removing translations without direct handling of the manager.
library;

export 'package:localization_pro/src/extensions/src/context.dart';

/// Exports extensions for `String`.
///
/// These extensions allow for direct string translation within UI code, simplifying
/// the process of retrieving localized strings. By using these extensions, strings
/// can be localized inline, enhancing the readability and maintainability of UI-related code.
export 'package:localization_pro/src/extensions/src/string.dart';
