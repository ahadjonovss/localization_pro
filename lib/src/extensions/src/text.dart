import 'package:flutter/material.dart';
import 'package:localization_pro/src/extensions/src/string.dart';

/// Extension on the Text widget to facilitate the creation of text widgets with localized strings.
///
/// This extension adds methods to the Text widget that simplify the process of creating text
/// with localized content from the localization provider. It leverages other extensions that
/// must be defined on String to fetch localized content, like `LocalizedStringExt`.
///
/// Examples:
/// ```dart
/// Text('hello').tr(context)
/// Text('welcome_message').trParams(context, params: {'userName': 'Alice'})
/// ```
extension LocalizedTextExt on Text {
  /// Creates a Text widget with a localized string obtained from the given context.
  ///
  /// This method enhances the Text widget by allowing for the easy integration of localized
  /// strings. It automatically fetches the translated string using the key provided in the
  /// data property of the Text widget.
  ///
  /// Parameters:
  ///   - context: The BuildContext to access the localization provider.
  ///   - style: An optional TextStyle to apply to the Text widget. Inherits the style from
  ///     the original Text widget if not specified.
  ///   - textAlign: An optional TextAlign to define how the text is aligned. Inherits the
  ///     alignment from the original Text widget if not specified.
  ///   - overflow: How visual overflow should be handled. Inherits the overflow setting
  ///     from the original Text widget if not specified.
  ///
  /// Returns:
  ///   A Text widget displaying the localized string.
  Text tr([BuildContext? context]) {
    return Text(
      data!.tr(
          context), // `data` is assumed to be a String (the text content of this widget).
      style: style,
      textAlign: textAlign,
      overflow: overflow,
    );
  }

  /// Creates a Text widget with a localized string obtained from the given context and formatted with parameters.
  ///
  /// This method is similar to `tr`, but it allows for dynamic substitution of parameters within the
  /// localized string. This is useful for strings that need to be formatted with specific values,
  /// such as user names, dates, numbers, etc.
  ///
  /// Parameters:
  ///   - context: The BuildContext to access the localization provider.
  ///   - params: A map of parameters to replace placeholders in the localized string.
  ///   - style: An optional TextStyle to apply to the Text widget. Inherits the style from
  ///     the original Text widget if not specified.
  ///   - textAlign: An optional TextAlign to define how the text is aligned. Inherits the
  ///     alignment from the original Text widget if not specified.
  ///   - overflow: How visual overflow should be handled. Inherits the overflow setting
  ///     from the original Text widget if not specified.
  ///
  /// Returns:
  ///   A Text widget displaying the localized string with parameters.
  Text trParams({required Map<String, dynamic> namedArgs, BuildContext? context}) {
    return Text(
      data!.trParams(namedArgs, context),
      style: style,
      textAlign: textAlign,
      overflow: overflow,
    );
  }


  Text trPlural(int count,{BuildContext? context}) {
    return Text(
      data!.trPlural(count, context),
      style: style,
      textAlign: textAlign,
      overflow: overflow,
    );
  }
}
