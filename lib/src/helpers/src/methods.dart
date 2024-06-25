import 'package:flutter/material.dart';
import 'package:localization_pro/src/extensions/src/string.dart';

/// Translates a key into a localized string.
///
/// - [key]: The key for the localized string.
/// - [context]: Optional build context for locale resolution.
/// - [namedArgs]: Optional named arguments for string formatting.
/// - [count]: Optional count for pluralization.
String tr(String key,
    {BuildContext? context, Map<String, dynamic>? namedArgs, int? count}) {
  // Early return if no special formatting or pluralization is needed
  if (namedArgs == null && count == null) {
    return key.tr(context);
  }

  // Handle pluralization
  String result = count != null ? key.trPlural(count) : key;

  // Apply named arguments if any
  if (namedArgs != null) {
    result = result.trParams(namedArgs);
  }

  return result.tr(context);
}
