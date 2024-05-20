import 'package:flutter/material.dart';
import 'package:localization_pro/src/provider/provider.dart';

/// Extension on String to provide easy access to translation methods.
///
/// This extension adds two methods, `tr` and `trParams`, to the String class,
/// allowing you to easily translate strings using the `LocalizationManager` provided by the `LocalizationProvider`.
extension LocalizedStringExt on String {
  /// Translates the string key using the `LocalizationManager` from the provided context.
  ///
  /// This method uses the `LocalizationManager` from the nearest `LocalizationProvider`
  /// in the widget tree to translate the string key. If the key is not found, the default
  /// not found text is returned.
  ///
  /// - Parameters:
  ///   - context: The `BuildContext` used to find the `LocalizationProvider` and `LocalizationManager`.
  ///
  /// - Returns: The translated string, or the default not found text if the key is not found.
  String tr(BuildContext context) {
    return LocalizationProvider.of(context).translate(this);
  }

  /// Translates the string key with parameters using the `LocalizationManager` from the provided context.
  ///
  /// This method uses the `LocalizationManager` from the nearest `LocalizationProvider`
  /// in the widget tree to translate the string key with the given parameters. Placeholders in the
  /// translation string are replaced with the values from the `params` map. If the key is not found,
  /// the default not found text is returned.
  ///
  /// - Parameters:
  ///   - context: The `BuildContext` used to find the `LocalizationProvider` and `LocalizationManager`.
  ///   - params: A map of parameters to replace placeholders in the translation string.
  ///
  /// - Returns: The translated string with parameters, or the default not found text if the key is not found.
  String trParams(BuildContext context, Map<String, dynamic> params) {
    return LocalizationProvider.of(context).translateWithParams(this, params);
  }
}
