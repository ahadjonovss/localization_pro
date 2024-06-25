import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localization_pro/src/helpers/src/logger.dart';
import 'package:localization_pro/src/manager/src/loader.dart';
import 'package:localization_pro/src/manager/src/translator.dart';
import 'package:localization_pro/src/models/models.dart';
import 'package:localization_pro/src/services/storage_service/storage_service.dart';
import '../utils/enums/src/log_type.dart';

/// Manages localization, handling translations and locales.
class LocalizationManager {
  /// Stores localized strings, where keys are translation keys and
  /// values are the translated strings.
  final Map<String, dynamic> _localizedStrings = {};

  /// The current locale being used by the localization manager.
  Locale currentLocale;

  /// List of supported locales.
  final List<SupportedLocale> supportedLocales;

  /// Flag to enable or disable debug mode for logging purposes.
  final bool debugMode;

  /// Logger instance used for logging messages.
  final Logger logger;

  /// Flag to determine if the locale should be saved to storage.
  bool saveLocale;

  /// Translator instance for handling translation operations.
  late final TranslatorPro translator;

  /// Loader instance for loading translation resources.
  late final LoaderPro loader;

  /// Creates a localization manager with the necessary initial setup.
  ///
  /// [supportedLocales] is a list of locales that the application supports.
  /// [initialLocale] is the locale to be set initially.
  /// [initialTranslations] is a list of initial translation keys to load.
  /// [debugMode] enables or disables debug logging.
  /// [saveLocale] determines whether to save the locale to persistent storage.
  LocalizationManager({
    required this.supportedLocales,
    required Locale initialLocale,
    required List<String> initialTranslations,
    required this.debugMode,
    this.saveLocale = true,
  })  : currentLocale = initialLocale,
        logger = Logger(debugMode: debugMode) {
    translator = TranslatorPro();
    loader = LoaderPro(logger);
    _init(initialTranslations, initialLocale);
  }

  /// Initializes the localization manager.
  ///
  /// [initialTranslations] is a list of translation keys to load initially.
  /// [initialLocale] is the locale to set initially.
  Future<void> _init(
      List<String> initialTranslations, Locale initialLocale) async {
    logger.log("Started initialing Localization PRO...", type: LogType.init);
    Locale? locale;
    if (saveLocale) {
      await StorageService.init();
      locale = StorageService.getLocale(initialLocale);
    }
    currentLocale = locale ?? initialLocale;
    loadInitialTranslations(currentLocale, initialTranslations.toSet());
  }

  /// Loads initial translations for the given locale.
  ///
  /// [locale] is the locale for which to load translations.
  /// [initialTranslations] is a set of translation keys to load initially.
  Future<void> loadInitialTranslations(
      Locale locale, Set<String> initialTranslations) async {
    loadTranslations(locale, initialTranslations);
    logger.log(
        "Finished Initializing Localization PRO with translations: "
        "$initialTranslations and Locale: $currentLocale",
        type: LogType.init);
  }

  /// Loads a single translation entry.
  ///
  /// [translation] is the translation to load.
  Future<void> loadTranslation(Translation translation) async {
    Map<String, dynamic> newTrs = await loader.loadTranslation(translation,
        supportedLocales: supportedLocales);
    _localizedStrings.addAll(newTrs);
  }

  /// Loads translations for the given locale and set of translation keys.
  ///
  /// [locale] is the locale for which to load translations.
  /// [translations] is a set of translation keys to load.
  /// [context] is the build context, used to mark
  /// the widget tree as needing a rebuild.
  Future<void> loadTranslations(Locale locale, Set<String> translations,
      [BuildContext? context]) async {
    Map<String, dynamic> newTrs = await loader.loadTranslations(locale,
        supportedLocales: supportedLocales, trs: translations);
    _localizedStrings.addAll(newTrs);
    if (context != null) {
      (context as Element).markNeedsBuild();
    }
  }

  /// Adds a translation to the manager and requests a UI update.
  ///
  /// [context] is the build context, used to mark the widget t
  /// ree as needing a rebuild. [translation] is the translation to add.
  void addTranslation(BuildContext context, Translation translation) {
    if (!loader.includedTranslations.contains(translation.name)) {
      loadTranslation(translation);
      (context as Element).markNeedsBuild();
      logger.log("Added Translation: ${translation.name}", type: LogType.info);
    }
  }

  /// Reloads a single translation and requests a UI update.
  ///
  /// [context] is the build context, used to mark the widget
  /// tree as needing a rebuild.
  /// [translation] is the translation to reload.
  void reLoadTranslation(
      BuildContext context, Translation translation) {
    loadTranslation(translation);
    (context as Element).markNeedsBuild();
    logger.log("Reloaded Translation: ${translation.name}", type: LogType.info);
  }

  /// Reloads all included translations and requests a UI update.
  ///
  /// [context] is the build context, used to mark the widget
  /// tree as needing a rebuild.
  void reLoadTranslations(BuildContext context) {
    loadTranslations(currentLocale, loader.includedTranslations, context);
    (context as Element).markNeedsBuild();
    logger.log("Reloaded Translations: ${loader.includedTranslations}",
        type: LogType.info);
  }

  /// Removes a translation and updates the manager's state.
  ///
  /// [context] is the build context, used to mark the widget
  /// tree as needing a rebuild.
  /// [translation] is the translation to remove.
  Future<void> removeTranslation(
      BuildContext context, Translation translation) async {
    Map<String, dynamic> json = await loader.loadTranslation(translation,
        supportedLocales: supportedLocales);
    List<String> keysToRemove = json.keys.toList();

    for (var key in keysToRemove) {
      _localizedStrings.remove(key);
      logger.log("Removed key: $key from translation: ${translation.name}",
          type: LogType.info);
    }

    loader.removeTranslation(translation.name);
    logger.log("Translation removed: ${translation.name}", type: LogType.info);

    (context as Element).markNeedsBuild();
  }

  /// Changes the current locale and reloads translations.
  ///
  /// [context] is the build context, used to mark the
  /// widget tree as needing a rebuild.
  /// [newLocale] is the new locale to set.
  Future<void> changeLocale(BuildContext context, Locale newLocale) async {
    currentLocale = newLocale;
    if (saveLocale) {
      await StorageService.setLocale(newLocale);
    }
    loadTranslations(newLocale, loader.includedTranslations);
    (context as Element).markNeedsBuild();
    logger.log("Changed locale to: ${newLocale.toLanguageTag()}",
        type: LogType.info);
  }

  /// Translates a given key.
  ///
  /// [key] is the translation key.
  /// Returns the translated string.
  String translate(String key) {
    return translator.translate(key, _localizedStrings);
  }

  /// Translates a given key with parameters.
  ///
  /// [key] is the translation key.
  /// [namedArgs] is a map of parameters for the translation.
  /// Returns the translated string with parameters.
  String translateWithParams(String key, Map<String, dynamic> namedArgs) {
    return translator.translateWithParams(key, namedArgs, _localizedStrings);
  }

  /// Returns the appropriate plural form of a string based on a given count.
  ///
  /// [key] is the translation key.
  /// [count] is the count for determining the plural form.
  /// Returns the translated plural form.
  String translatePlural(String key, int count) {
    return translator.translatePlural(key, count, _localizedStrings);
  }
}
