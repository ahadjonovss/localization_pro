/// Exports for the Localization component of the Localization Pro package.
///
/// This file provides a centralized export of key classes used in the localization
/// process within the application. By importing this file, other parts of the application
/// can access the necessary classes for managing and utilizing localized resources.
library;

// Exporting the SupportedTranslation class which details individual translations
// including their names and file paths, used by the LocalizationManager.
export 'package:localization_pro/src/models/src/supported_locale.dart';
// Exporting the SupportedLocale class which represents a specific locale supported
// by the application along with its associated translations.
export 'package:localization_pro/src/models/src/supported_translation.dart';
