import 'package:flutter/material.dart';
import 'package:localization_pro/src/manager/localization_manager.dart';
import 'package:localization_pro/src/provider/provider.dart';

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
}
