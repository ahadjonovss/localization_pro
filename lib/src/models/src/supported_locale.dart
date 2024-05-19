import 'dart:ui';

import 'package:localization_pro/src/models/src/supported_translation.dart';

/// Represents a locale supported by the application, along with its associated translations.
///
/// This class encapsulates the details of a specific locale (language and region) and the
/// translations that are available for that locale. It's used by the LocalizationManager
/// to load and manage localized content.
class SupportedLocale {
  /// The locale represented by this instance.
  ///
  /// This typically includes a language code (e.g., 'en') and possibly a country code (e.g., 'US'),
  /// which together specify the language and regional settings for which the translations apply.
  final Locale locale;

  /// The list of translations available for this locale.
  ///
  /// Each SupportedTranslation contains the information necessary to load and manage a set
  /// of localized strings for this locale, such as file paths or keys that correspond to
  /// localized content.
  final List<SupportedTranslation> translations;

  /// Constructs a SupportedLocale with a specific locale and list of translations.
  ///
  /// This constructor requires all parameters to be provided and cannot be called without them.
  /// [locale] specifies the locale for the translations, and [translations] provides the detailed
  /// translation objects that include path and name information needed for localization operations.
  SupportedLocale({required this.locale, required this.translations});
}
