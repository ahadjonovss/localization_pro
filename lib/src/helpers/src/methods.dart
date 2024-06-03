import 'package:flutter/material.dart';
import 'package:localization_pro/src/extensions/src/string.dart';

/// Translates a given string key using the localization facilities provided by `LocalizedStringExt` extension.
///
/// This function simplifies the translation process by wrapping the `tr` method of the `LocalizedStringExt` extension.
/// It is used for straightforward translation without parameters and utilizes the localization system initialized in the app.
/// If the translation key is not found, it defaults to a "Key not found" message.
///
/// Usage example:
/// ```dart
/// Text(tr('hello'))
/// ```
///
/// - Parameters:
///   - key: The key for the string that needs to be translated.
///   - context: Optional. The `BuildContext` used to find the `LocalizationProvider`. If not provided,
///     it tries to use the nearest context available.
///
/// - Returns: The translated string corresponding to the given key.
String tr(String key,
    {BuildContext? context, Map<String, dynamic>? namedArgs}) {
  if (namedArgs != null) {
    return key.trParams(namedArgs);
  }
  return key.tr(context);
}
