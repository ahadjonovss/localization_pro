import 'package:flutter/material.dart';
import 'package:localization_pro/src/provider/provider.dart';

/// Extension on String to provide easy access to translation methods.
///
/// This extension adds two methods, `tr` and `trParams`, to the String class,
/// allowing you to easily translate strings within the Flutter application using
/// the `LocalizationManager` provided by the `LocalizationProvider`. These methods facilitate
/// obtaining localized text, which is essential for supporting multiple languages in the app.
extension LocalizedStringExt on String {
  /// Translates the string key using the `LocalizationManager` from the provided context.
  ///
  /// This method retrieves the translation of the string key from the nearest `LocalizationProvider`
  /// in the widget tree. If the key is not found, a default "Key not found" text is returned, which can be customized.
  /// It is a simpler version of translation that does not involve replacing parameters.
  ///
  /// Usage example:
  /// ```dart
  /// Text('hello'.tr(context))
  /// ```
  ///
  /// - Parameters:
  ///   - context: The `BuildContext` used to find the `LocalizationProvider` and access the `LocalizationManager`.
  ///
  /// - Returns: The translated string, or the default "Key not found" text if the translation key is not found.
  String tr([BuildContext? context]) {
    return LocalizationProvider.of(context).translate(this);
  }

  /// Translates the string key with parameters using the `LocalizationManager` from the provided context.
  ///
  /// This method uses the `LocalizationManager` from the nearest `LocalizationProvider`
  /// in the widget tree to translate the string key with the given parameters. Placeholders in the
  /// translation string are replaced with the values from the `params` map. For example, if the translation
  /// string is "Hello, {name}!", and `params` is `{'name': 'World'}`, the output will be "Hello, World!".
  /// If the key is not found, it returns a predefined "Key not found" message, which can be customized.
  ///
  /// Usage example:
  /// ```dart
  /// Text('greeting'.trParams({'name': 'World'}, context))
  /// ```
  ///
  /// - Parameters:
  ///   - params: A map of string keys to dynamic values used to replace placeholders in the translation string.
  ///   - context: Optional. The `BuildContext` used to locate the `LocalizationProvider` and access the `LocalizationManager`.
  ///
  /// - Returns: The translated string with parameters inserted, or a "Key not out found" message if the translation key is not found.
  /// - Throws: Throws an exception if `LocalizationProvider` is not found in the widget tree.
  String trParams(Map<String, dynamic> namedArgs, [BuildContext? context]) {
    return LocalizationProvider.of(context).translateWithParams(this, namedArgs);
  }

  String trPlural(int count,[BuildContext? context]) {
    return LocalizationProvider.of(context).translatePlural(this,count);
  }

}
