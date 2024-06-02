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
String tr(String key, {BuildContext? context}) {
  return key.tr(context);
}

/// Translates a given string key with parameters using the localization facilities provided by `LocalizedStringExt` extension.
///
/// This function wraps the `trParams` method of the `LocalizedStringExt` extension to allow for dynamic translations
/// where placeholders in the string can be replaced with provided parameter values. It is useful for customized translations
/// such as "Hello, {name}!" where `params` would be `{'name': 'John'}`.
///
/// Usage example:
/// ```dart
/// Text(trParams('greeting', params: {'name': 'John'}))
/// ```
///
/// - Parameters:
///   - key: The key for the string that needs to be translated with parameters.
///   - params: A map containing the parameters to replace the placeholders in the string.
///   - context: Optional. The `BuildContext` used to find the `LocalizationProvider`. If not provided,
///     it tries to use the nearest context available.
///
/// - Returns: The translated string with parameters inserted.
String trParams(String key, {required Map<String, dynamic> params, BuildContext? context}) {
  return key.trParams(params, context);
}
