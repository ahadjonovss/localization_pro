import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localization_pro/src/helpers/helpers.dart';
import 'package:localization_pro/src/models/models.dart';

/// Manages localization resources for a Flutter application, handling the dynamic loading,
/// adding, and removing of localized strings, with logging capabilities.
class LocalizationManager {
  /// Stores the localized strings loaded for the current locale.
  final Map<String, String> _localizedStrings = {};

  /// Tracks the translations that have been loaded.
  final Set<String> _includedTranslations = {};

  /// Current locale used by the localization manager.
  Locale currentLocale;

  /// List of all supported locales and their respective translations.
  final List<SupportedLocale> supportedLocales;

  /// Logger instance for handling debug output.
  final Logger logger;

  /// Constructs a localization manager with initial settings.
  LocalizationManager({
    required this.supportedLocales,
    required Locale initialLocale,
    required List<String> initialTranslations,
    required bool debugMode,
  })  : currentLocale = initialLocale,
        logger = Logger(debugMode: debugMode) {
    logger.log("Initializing Localization Manager");
    loadInitialTranslations(initialLocale, initialTranslations.toSet());
  }

  /// Loads the initial translations for a given locale from the specified translations list.
  void loadInitialTranslations(Locale locale, Set<String> initialTranslations) {
    logger.log(
        "Loading initial translations for locale: ${locale.toLanguageTag()}");
    for (String name in initialTranslations) {
      var translation = supportedLocales
          .firstWhere((l) => l.locale == locale)
          .translations
          .firstWhere((t) => t.name == name);
      loadTranslation(translation);
    }
  }

  /// Loads a specific translation, adding its content to the internal map of localized strings.
  void loadTranslation(SupportedTranslation translation) {
    logger.log("Loading translation: ${translation.name}");
    rootBundle.loadString(translation.path).then((data) {
      Map<String, dynamic> jsonMap = json.decode(data);
      _localizedStrings
          .addAll(jsonMap.map((key, value) => MapEntry(key, value.toString())));
      _includedTranslations.add(translation.name);
      logger.log("Translation loaded: ${translation.name}");
    });
  }

  /// Adds a translation if it is not already included, triggering a UI rebuild.
  void addTranslation(BuildContext context, SupportedTranslation translation) {
    if (!_includedTranslations.contains(translation.name)) {
      loadTranslation(translation);
      (context as Element).markNeedsBuild();
    }
  }

  /// Removes a translation and its associated keys from the internal map,
  /// triggering a UI rebuild.
  void removeTranslation(
      BuildContext context, SupportedTranslation translation) {
    logger.log("Attempting to remove translation: ${translation.name}");
    rootBundle.loadString(translation.path).then((jsonString) {
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      List<String> keysToRemove = jsonMap.keys.toList();

      keysToRemove.forEach((key) {
        _localizedStrings.remove(key);
        logger.log("Removed key: $key from translation: ${translation.name}");
      });

      _includedTranslations.remove(translation.name);
      logger.log("Translation removed: ${translation.name}");

      (context as Element).markNeedsBuild();
    }).catchError((error) {
      logger.log("Error removing translation: ${error.toString()}");
    });
  }

  /// Changes the current locale, reloading all necessary translations and
  /// triggering a UI rebuild.
  void changeLocale(BuildContext context, Locale newLocale) {
    logger.log("Changing locale to: ${newLocale.toLanguageTag()}");
    currentLocale = newLocale;
    loadInitialTranslations(newLocale, _includedTranslations);
    (context as Element).markNeedsBuild();
  }

  /// Retrieves a localized string by key, returning a default message if not found.
  String translate(String key) {
    return _localizedStrings[key] ?? 'Translation not found';
  }
}
