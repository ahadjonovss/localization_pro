import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:localization_pro/localization_provider.dart';
import '../../utils/enums/src/log_type.dart';

/// Handles loading and managing translations.
class LoaderPro {
  /// Logger instance for logging messages.
  final Logger logger;

  /// Set of included translations' names.
  final Set<String> _includedTranslations = {};

  /// Constructor for LoaderPro, initializes the logger.
  LoaderPro(this.logger);

  /// Gets the included translations.
  Set<String> get includedTranslations => _includedTranslations;

  /// Loads a single translation from the specified [translation] object.
  ///
  /// This method reads the translation file, parses the JSON,
  /// and adds the translations to the [_localizedStrings] map.
  /// [translation] is the translation object to load.
  /// [supportedLocales] is the list of supported locales.
  Future<Map<String, dynamic>> loadTranslation(
    Translation translation, {
    required List<SupportedLocale> supportedLocales,
  }) async {
    logger.log("Loading translation: ${translation.name}", type: LogType.info);
    Map<String, String> localizedStrings = {};
    try {
      final data = await rootBundle.loadString(translation.path);
      Map<String, dynamic> jsonMap = json.decode(data);
      localizedStrings.addAll(flattenJsonMap(jsonMap));
      _includedTranslations.add(translation.name);
      logger.log("Translation loaded: ${translation.name}", type: LogType.info);
    } catch (e) {
      logger.log("Error loading translation: ${e.toString()}",
          type: LogType.error);
    }
    return localizedStrings;
  }

  /// Loads translations for the given locale and set of translation keys.
  ///
  /// [locale] is the locale for which to load translations.
  /// [supportedLocales] is the list of supported locales.
  /// [trs] is the set of translation keys to load.
  Future<Map<String, dynamic>> loadTranslations(
    Locale locale, {
    required List<SupportedLocale> supportedLocales,
    required Set<String> trs,
  }) async {
    Map<String, dynamic> translations = {};
    for (String name in trs) {
      var translation = supportedLocales
          .firstWhere((l) => l.locale == locale)
          .translations
          .firstWhere((t) => t.name == name);
      Map<String, dynamic> newTrs = await loadTranslation(translation,
          supportedLocales: supportedLocales);
      translations.addAll(newTrs);
    }
    return translations;
  }

  /// Flattens a nested JSON map into a single-level map with dot-separated keys.
  ///
  /// [json] is the nested JSON map to flatten.
  /// [prefix] is the prefix for keys in the flattened map.
  /// Returns a flattened map.
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

  /// Loads initial translations for the given [locale] and [initialTranslations].
  ///
  /// [locale] is the locale for which to load initial translations.
  /// [supportedLocales] is the list of supported locales.
  /// [initialTranslations] is the set of initial translation keys to load.
  Future<Map<String, dynamic>> loadInitialTranslations(
    Locale locale, {
    required List<SupportedLocale> supportedLocales,
    required Set<String> initialTranslations,
  }) async {
    logger.log(
        "Loading initial translations for locale: ${locale.toLanguageTag()}",
        type: LogType.init);
    return await loadTranslations(locale,
        supportedLocales: supportedLocales, trs: initialTranslations);
  }

  /// Reloads a single specified translation.
  ///
  /// [translation] is the translation to reload.
  /// [supportedLocales] is the list of supported locales.
  Future<Map<String, dynamic>> reLoadTranslation(
    Translation translation,
    List<SupportedLocale> supportedLocales,
  ) async {
    return await loadTranslation(translation,
        supportedLocales: supportedLocales);
  }

  /// Reloads all included translations.
  ///
  /// [supportedLocales] is the list of supported locales.
  /// [currentLocale] is the current locale.
  /// [trs] is the set of translation keys to reload.
  Future<Map<String, dynamic>> reLoadTranslations(
    List<SupportedLocale> supportedLocales,
    Locale currentLocale,
    Set<String> trs,
  ) async {
    return await loadTranslations(currentLocale,
        supportedLocales: supportedLocales, trs: trs);
  }

  /// Adds a translation to the set of included translations.
  ///
  /// [translation] is the name of the translation to add.
  void addTranslation(String translation) {
    _includedTranslations.add(translation);
  }

  /// Removes a translation from the set of included translations.
  ///
  /// [translation] is the name of the translation to remove.
  void removeTranslation(String translation) {
    _includedTranslations.remove(translation);
  }

  /// Checks if a translation is included in the set of included translations.
  ///
  /// [translation] is the name of the translation to check.
  /// Returns true if the translation is included, otherwise false.
  bool hasTranslation(String translation) {
    return _includedTranslations.contains(translation);
  }
}
