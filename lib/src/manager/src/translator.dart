class TranslatorPro {
  /// Translates a key to its localized string.
  ///
  /// This method returns the localized string for the given [key].
  /// If the key is not found, it returns the [defaultNotFoundText].
  String translate(String key, Map<String, dynamic> localizedStrings) {
    return localizedStrings[key] ?? key;
  }

  /// Translates a key with parameters to its localized string.
  ///
  /// This method returns the localized string for the given [key] with the specified [namedArgs]
  /// replaced in the translation string.
  String translateWithParams(String key, Map<String, dynamic> namedArgs,
      Map<String, dynamic> localizedStrings) {
    String translation = translate(key, localizedStrings);
    namedArgs.forEach((paramKey, value) {
      translation = translation.replaceAll('{$paramKey}', value.toString());
    });
    return translation;
  }

  /// Translates a key with plural handling based on the count.
  /// [key]: The base key used for fetching the plural forms.
  /// [count]: The quantity for which the correct plural form is determined.
  /// Returns the appropriate plural string according to the [count].
  String translatePlural(
      String key, int count, Map<String, dynamic> localizedStrings) {
    String pluralCategory = _getPluralCategory(count);
    String newKey = '$key.$pluralCategory';
    String? translation =
        localizedStrings[newKey] ?? localizedStrings[key]?['$key.other'];

    translation ??= key;

    return translation.replaceFirst('{}', count.toString());
  }

  /// Determines the plural category based on the given [count].
  /// Returns a string key representing the plural category.
  String _getPluralCategory(int count) {
    if (count == 0) {
      return 'zero';
    } else if (count == 1) {
      return 'one';
    } else if (count == 2) {
      return 'two';
    } else if (count > 2 && count < 5) {
      return 'few';
    } else if (count >= 5) {
      return 'many';
    }
    return 'other';
  }
}
