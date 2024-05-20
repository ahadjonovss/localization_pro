import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localization_pro/src/helpers/src/logger.dart';
import 'package:localization_pro/src/models/models.dart';
import '../utils/enums/src/log_type.dart';

/// Manages localization for the application, including loading, adding,
/// and removing translations, and changing locales.
class LocalizationManager {
  /// Map of localized strings where keys are translation keys and values are translations.
  final Map<String, String> _localizedStrings = {};

  /// Set of included translations' names.
  final Set<String> _includedTranslations = {};

  /// The current locale being used by the localization manager.
  Locale currentLocale;

  /// List of supported locales and their respective translations.
  final List<SupportedLocale> supportedLocales;

  /// Indicates whether debug mode is enabled.
  final bool debugMode;

  /// Logger for logging messages with different log types.
  final Logger logger;

  /// Default text to be used when a translation key is not found.
  String defaultNotFoundText;

  /// Constructs a [LocalizationManager] with the given parameters.
  ///
  /// [supportedLocales] is the list of supported locales.
  /// [initialLocale] is the initial locale to be used.
  /// [initialTranslations] is the list of initial translations to load.
  /// [debugMode] indicates whether debug mode is enabled.
  /// [defaultNotFoundText] is the default text to be used when a translation key is not found.
  LocalizationManager({
    required this.supportedLocales,
    required Locale initialLocale,
    required List<String> initialTranslations,
    required this.debugMode,
    this.defaultNotFoundText = 'Translation not found',
  })  : currentLocale = initialLocale,
        logger = Logger(debugMode: debugMode) {
    loadInitialTranslations(initialLocale, initialTranslations.toSet());
  }

  /// Loads initial translations for the given [locale] and [initialTranslations].
  ///
  /// This method loads the initial set of translations specified by [initialTranslations]
  /// for the specified [locale].
  void loadInitialTranslations(Locale locale, Set<String> initialTranslations) {
    logger.log(
        "Loading initial translations for locale: ${locale.toLanguageTag()}",
        type: LogType.init);
    for (String name in initialTranslations) {
      var translation = supportedLocales
          .firstWhere((l) => l.locale == locale)
          .translations
          .firstWhere((t) => t.name == name);
      loadTranslation(translation);
    }
  }

  /// Loads a single translation from the specified [translation] object.
  ///
  /// This method reads the translation file, parses the JSON, and adds the translations
  /// to the [_localizedStrings] map.
  Future<void> loadTranslation(SupportedTranslation translation) async {
    logger.log("Loading translation: ${translation.name}", type: LogType.info);
    try {
      final data = await rootBundle.loadString(translation.path);
      Map<String, dynamic> jsonMap = json.decode(data);
      _localizedStrings.addAll(flattenJsonMap(jsonMap));
      _includedTranslations.add(translation.name);
      logger.log("Translation loaded: ${translation.name}", type: LogType.info);
    } catch (e) {
      logger.log("Error loading translation: ${e.toString()}",
          type: LogType.error);
    }
  }

  /// Flattens a nested JSON map into a single-level map with dot-separated keys.
  ///
  /// This method takes a nested [json] map and recursively flattens it into a map
  /// with keys representing the path to each value in the original map.
  Map<String, String> flattenJsonMap(Map<String, dynamic> json,
      [String prefix = '']) {
    Map<String, String> flatMap = {};
    json.forEach((key, value) {
      String newPrefix = prefix.isEmpty ? key : "$prefix.$key";
      if (value is Map) {
        flatMap
            .addAll(flattenJsonMap(value as Map<String, dynamic>, newPrefix));
      } else {
        flatMap[newPrefix] = value.toString();
      }
    });
    return flatMap;
  }

  /// Adds a translation to the localization manager and marks the context for rebuild.
  ///
  /// This method loads the specified [translation] and adds it to the manager.
  void addTranslation(BuildContext context, SupportedTranslation translation) {
    if (!_includedTranslations.contains(translation.name)) {
      loadTranslation(translation);
      (context as Element).markNeedsBuild();
    }
  }

  /// Removes a translation from the localization manager and marks the context for rebuild.
  ///
  /// This method removes the specified [translation] and updates the manager's state.
  void removeTranslation(
      BuildContext context, SupportedTranslation translation) {
    logger.log("Attempting to remove translation: ${translation.name}",
        type: LogType.info);
    rootBundle.loadString(translation.path).then((jsonString) {
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      List<String> keysToRemove = jsonMap.keys.toList();

      // Now remove these keys from _localizedStrings
      for (var key in keysToRemove) {
        _localizedStrings.remove(key);
        logger.log("Removed key: $key from translation: ${translation.name}",
            type: LogType.info);
      }

      // Also remove the translation name from the list of included translations
      _includedTranslations.remove(translation.name);
      logger.log("Translation removed: ${translation.name}",
          type: LogType.info);

      // Inform the widget tree about the update
      (context as Element).markNeedsBuild();
    }).catchError((error) {
      logger.log("Error removing translation: ${error.toString()}",
          type: LogType.error);
    });
  }

  /// Changes the current locale and reloads translations.
  ///
  /// This method sets the [newLocale] as the current locale and reloads the initial translations
  /// for the new locale.
  void changeLocale(BuildContext context, Locale newLocale) {
    logger.log("Changing locale to: ${newLocale.toLanguageTag()}",
        type: LogType.info);
    currentLocale = newLocale;
    loadInitialTranslations(newLocale, _includedTranslations);
    (context as Element).markNeedsBuild();
  }

  /// Translates a key to its localized string.
  ///
  /// This method returns the localized string for the given [key].
  /// If the key is not found, it returns the [defaultNotFoundText].
  String translate(String key) {
    return _localizedStrings[key] ?? defaultNotFoundText;
  }

  /// Translates a key with parameters to its localized string.
  ///
  /// This method returns the localized string for the given [key] with the specified [params]
  /// replaced in the translation string.
  String translateWithParams(String key, Map<String, dynamic> params) {
    String translation = translate(key);
    params.forEach((paramKey, value) {
      translation = translation.replaceAll('{$paramKey}', value.toString());
    });
    return translation;
  }
}
