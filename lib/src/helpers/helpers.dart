/// A library that exports helper utilities for the localization package.
///
/// This includes classes and functions that assist with various tasks,
/// such as logging, used throughout the localization package.
/// The library facilitates debugging, event tracking, and dynamic content translation
/// in applications that require support for multiple languages.
library helpers;

/// Exports the Logger class for logging purposes.
///
/// The Logger class provides a simple logging mechanism that can be enabled
/// or disabled based on the debug mode. It helps in debugging and tracking
/// events during the localization process. It is especially useful for identifying
/// and troubleshooting issues related to language data handling and translation loading.
export 'package:localization_pro/src/helpers/src/logger.dart';

/// Exports the Translator class, which provides methods for translating text.
///
/// The Translator class is used to manage and facilitate the translation of text within
/// the application. It works by retrieving translation strings from a set of predefined
/// localization files or databases, and substituting variables and placeholders as needed.
/// This class is crucial for applications that need to handle dynamic content translation
/// in multiple languages efficiently.
export 'package:localization_pro/src/helpers/src/translator.dart';
