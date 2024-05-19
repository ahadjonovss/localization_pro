import 'package:flutter/material.dart';
import 'package:localization_pro/src/provider/provider.dart';

/// Extends the [String] class to provide an easy and convenient way to
/// translate text directly from string literals or variables.
///
/// By calling the `tr()` method on any string, the text is automatically
/// localized using the translations available in the nearest [LocalizationProvider]
/// up the widget tree.
extension LocalizedStringExt on String {
  /// Translates the string based on the current locale's translations.
  ///
  /// This method looks up the nearest [LocalizationProvider] from the provided [context],
  /// and attempts to translate the current string. If no translation is found, the original
  /// string is returned as a fallback.
  ///
  /// Example usage:
  /// ```dart
  /// 'hello'.tr(context)
  /// ```
  ///
  /// [context] The build context from which to find the [LocalizationProvider].
  /// Returns the translated string if a match is found, or the original string if not.
  String tr(BuildContext context) {
    return LocalizationProvider.of(context).translate(this);
  }
}
