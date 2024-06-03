import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:localization_pro/localization_provider.dart';
import '../../utils/enums/src/log_type.dart';

class LoaderPro {
  final Logger logger;

  /// Set of included translations' names.
  final Set<String> _includedTranslations = {};

  LoaderPro(this.logger);

  get includedTranslations => _includedTranslations;

  /// Loads a single translation from the specified [translation] object.
  ///
  /// This method reads the translation file, parses the JSON, and adds the translations
  /// to the [_localizedStrings] map.
  Future<Map<String, dynamic>> loadTranslation(
    SupportedTranslation translation, {
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

  /// Loads initial translations for the given [locale] and [initialTranslations].
  ///
  /// This method loads the initial set of translations specified by [initialTranslations]
  /// for the specified [locale].
  Future<Map<String, dynamic>> loadInitialTranslations(
    Locale locale, {
    required List<SupportedLocale> supportedLocales,
    required Set<String> initialTranslations,
  }) async {
    late Map<String, dynamic> translations;
    logger.log(
        "Loading initial translations for locale: ${locale.toLanguageTag()}",
        type: LogType.init);
    translations = await loadTranslations(locale,
        supportedLocales: supportedLocales, trs: initialTranslations);

    return translations;
  }

  /// Reloads a single specified translation and marks the UI as needing to be rebuilt.
  ///
  /// This function reloads a particular translation using the `loadTranslation` function and then
  /// forces the widget associated with the provided context to rebuild, ensuring the updated
  /// translation is displayed.
  ///
  /// Parameters:
  ///   - `context` [BuildContext]: The context in which the widget resides that needs updating.
  ///   - `translation` [SupportedTranslation]: The specific translation to reload.
  Future<Map<String, dynamic>> reLoadTranslation(
    SupportedTranslation translation,
    List<SupportedLocale> supportedLocales,
  ) async {
    late Map<String, dynamic> translations;

    // Load the specific translation.
    translations =
        await loadTranslation(supportedLocales: supportedLocales, translation);
    return translations;
  }

  /// Reloads all included translations and marks the UI as needing to be rebuilt.
  ///
  /// This function iterates over a predefined list of translation names, retrieves and reloads each
  /// from the supported locales, and finally forces the widget in the provided context to rebuild.
  /// This is used when multiple translations need to be updated at once.
  ///
  /// Parameters:
  ///   - `context` [BuildContext]: The context in which the widget resides that needs updating.
  Future<Map<String, dynamic>> reLoadTranslations(
    List<SupportedLocale> supportedLocales,
    Locale currentLocale,
    Set<String> trs,
  ) async {
    late Map<String, dynamic> translations;
    translations = await loadTranslations(currentLocale,
        supportedLocales: supportedLocales, trs: trs);
    return translations;
  }

  void addTranslation(String translation) {
    _includedTranslations.add(translation);
  }

  void removeTranslation(String translation) {
    _includedTranslations.add(translation);
  }

  bool hasTranslation(String translation) {
    return _includedTranslations.contains(translation);
  }
}
