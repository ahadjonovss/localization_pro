/// Exports extensions for `BuildContext`.
///
/// This library module contains extensions that add convenience methods to `BuildContext`,
/// facilitating direct access to localization functionalities. These extensions simplify the
/// interaction with the `LocalizationManager`, allowing widgets to dynamically manage translations
/// and locales. This abstraction layer helps developers change locales, add, or remove translations
/// without directly manipulating the underlying localization manager. This approach promotes cleaner,
/// more maintainable code by encapsulating localization logic within context-related operations.
///
/// The `context.dart` extension provides methods that enable widgets to modify localization settings
/// directly through their `BuildContext`, which can be particularly useful in response to user interactions
/// (like switching languages).
library context_extensions;

export 'package:localization_pro/src/extensions/src/context.dart';

/// Exports extensions for `String`.
///
/// This part of the library offers extensions on the `String` class, designed to enhance the ease
/// of translating text within the UI code. By integrating these extensions, developers can perform
/// inline translations of string literals and variables, which improves the readability and maintainability
/// of the code dealing with user-facing text.
///
/// The extensions include methods for translating strings directly, supporting parameterized translations
/// (where dynamic values are inserted into the translated text), and handling plurals or other localization
/// nuances. These functionalities reduce boilerplate and centralize text processing in UI components,
/// leading to cleaner Flutter codebases.
export 'package:localization_pro/src/extensions/src/string.dart';

/// Exports extensions for `Text` widget.
///
/// These extensions are designed to simplify the creation of localized `Text` widgets by extending
/// the Flutter `Text` widget itself. Developers can use these extensions to wrap string literals
/// or variables with localization methods directly within `Text` widget declarations, streamlining
/// the process of displaying localized text on the UI.
///
/// Usage of these extensions ensures that `Text` widgets are always created with the correct localized
/// strings, avoiding common pitfalls of manual string localization handling and improving overall
/// consistency across the application's user interface.
export 'package:localization_pro/src/extensions/src/text.dart';
