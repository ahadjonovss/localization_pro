import 'package:localization_pro/src/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:localization_pro/src/manager/localization_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// Extends [BuildContext] to provide easy access to [LocalizationManager] methods.
///
/// This extension adds several convenience methods to any [BuildContext],
/// facilitating the management of localization actions directly from the context.
extension LocalizationExt on BuildContext {
  /// Retrieves the [LocalizationManager] from the nearest [LocalizationProvider] in the widget tree.
  ///
  /// This property makes it simpler to access the [LocalizationManager] without repeatedly
  /// having to type the full [LocalizationProvider.of] call.
  LocalizationManager get locManager => LocalizationProvider.of(this);

  /// Adds a translation resource by its name.
  ///
  /// This method searches for a [SupportedTranslation] by name within the current locale's
  /// supported translations and initiates its loading.
  ///
  /// [name] The unique name of the translation to be added.
  void addTranslation(String name) {
    var translation = locManager.supportedLocales
        .firstWhere((l) => l.locale == locManager.currentLocale)
        .translations
        .firstWhere((t) => t.name == name);
    locManager.addTranslation(this, translation);
  }

  /// Reloads a specific translation by its name for the current locale.
  ///
  /// This function retrieves a translation matching the given name from the list of supported locales
  /// and then reloads it using the localization manager (`locManager`).
  ///
  /// Parameters:
  ///   - `name` [String]: The name of the translation to reload.
  void reloadTranslation(String name) {
    // Retrieves the translations for the current locale.
    var translation = locManager.supportedLocales
        // Finds the locale that matches the current locale.
        .firstWhere((l) => l.locale == locManager.currentLocale)
        // From the matched locale, find the translation by its name.
        .translations
        .firstWhere((t) => t.name == name);
    // Reloads the specific translation found above.
    locManager.reLoadTranslation(this, translation);
  }

  /// Reloads all translations for the current context.
  ///
  /// This function triggers a reload of all translations within the current locale context
  /// using the localization manager (`locManager`).
  void reloadTranslations() {
    // Reloads all translations using the localization manager for the current context.
    locManager.reLoadTranslations(this);
  }

  /// Removes a translation resource by its name.
  ///
  /// This method finds the specified [SupportedTranslation] within the current locale's
  /// translations and initiates its removal.
  ///
  /// [name] The unique name of the translation to be removed.
  void removeTranslation(String name) {
    var translation = locManager.supportedLocales
        .firstWhere((l) => l.locale == locManager.currentLocale)
        .translations
        .firstWhere((t) => t.name == name);
    locManager.removeTranslation(this, translation);
  }

  /// Changes the application's current locale.
  ///
  /// This method triggers a change in the locale used by the [LocalizationManager],
  /// resulting in the loading of new translations appropriate to the [newLocale].
  ///
  /// [newLocale] The new locale to which the application should switch.
  void changeLocale(Locale newLocale) {
    locManager.changeLocale(this, newLocale);
  }

  /// Retrieves the current locale from the [LocalizationProvider].
  Locale get locale => LocalizationProvider.of(this).currentLocale;

  /// Returns a list of localization delegates including:
  /// - [GlobalMaterialLocalizations.delegate]
  /// - [GlobalWidgetsLocalizations.delegate]
  /// - [GlobalCupertinoLocalizations.delegate]
  Iterable<LocalizationsDelegate<dynamic>> get localizationsDelegates => [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ];

  /// Retrieves the list of supported locales by mapping them from the [LocalizationProvider].
  Iterable<Locale> get supportedLocales =>
      LocalizationProvider.of(this).supportedLocales.map((e) => e.locale);
}
