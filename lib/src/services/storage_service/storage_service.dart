import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

/// A service class for storing and retrieving locale settings using the SharedPreferences library.
///
/// This class provides static methods to initialize SharedPreferences, save a locale,
/// and retrieve a locale. It handles both the language code and optional country code for
/// locale settings. If a stored locale is not found, it returns a default locale provided
/// during retrieval.
///
/// Methods:
/// - [init]: Asynchronously initializes the SharedPreferences instance.
/// - [setLocale]: Saves the locale's language code and, optionally, the country code to SharedPreferences.
/// - [getLocale]: Retrieves the locale from SharedPreferences. If no locale is saved,
///   it returns the default locale provided to the method.
///
/// Usage:
/// Before using [setLocale] or [getLocale], [init] must be called to ensure that
/// SharedPreferences is ready. [setLocale] can then be used to save a user's locale preference,
/// and [getLocale] can be used to retrieve this preference with a fallback to a default locale.
///
/// Example:
/// ```
/// await StorageService.init();
/// Locale userLocale = Locale('en', 'US');
/// await StorageService.setLocale(userLocale);
/// Locale currentLocale = StorageService.getLocale(Locale('en', 'US'));
/// ```
///
/// This class is especially useful in applications supporting multiple locales, allowing for
/// dynamic locale switching and persistence across sessions.
class StorageService {
  static SharedPreferences? _preferences;

  /// Initializes the SharedPreferences instance asynchronously.
  ///
  /// This method should be called before any other methods of this class. It ensures that
  /// SharedPreferences is available and ready to use throughout the application.
  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  /// Saves the locale settings in SharedPreferences.
  ///
  /// This method stores the language code and, if available, the country code of the locale.
  /// If the country code is not provided, any existing country code is removed from storage.
  ///
  /// Parameters:
  /// - [locale]: The `Locale` object containing the language and country code to store.
  static Future setLocale(Locale locale) async {
    await _preferences?.setString('languageCode', locale.languageCode);
    if (locale.countryCode != null) {
      await _preferences?.setString('countryCode', locale.countryCode!);
    } else {
      await _preferences?.remove('countryCode');
    }
  }

  /// Retrieves the locale from SharedPreferences.
  ///
  /// This method returns the locale stored in SharedPreferences. If no locale is stored,
  /// it returns the [defaultLocale] provided to the method.
  ///
  /// Parameters:
  /// - [defaultLocale]: A `Locale` object to return if no locale is stored in SharedPreferences.
  ///
  /// Returns:
  /// A `Locale` object, either retrieved from SharedPreferences or the default locale provided.
  static Locale getLocale(Locale defaultLocale) {
    String? languageCode = _preferences?.getString('languageCode');
    String? countryCode = _preferences?.getString('countryCode');

    if (languageCode != null) {
      return Locale(languageCode, countryCode);
    } else {
      return defaultLocale;
    }
  }
}
