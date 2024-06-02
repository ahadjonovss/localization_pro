import 'package:flutter/material.dart';
import 'package:localization_pro/src/manager/localization_manager.dart';

/// Provides a localization manager to the widget tree.
///
/// This class uses the InheritedWidget pattern to propagate the localization manager
/// down the widget tree, allowing widgets to access localization functionalities
/// provided by [LocalizationManager].
class LocalizationProvider extends InheritedWidget {
  /// The key used to access the [LocalizationProvider] instance.
  static GlobalKey instanceKey = GlobalKey();

  /// The localization manager that holds and manages all localization data.
  final LocalizationManager localizationManager;

  /// Constructs a [LocalizationProvider] that exposes [localizationManager]
  /// to its descendants.
  ///
  /// [key] Identifies this widget in the widget tree.
  /// [child] The widget below this widget in the tree that can access the provided
  /// [localizationManager].
  /// [localizationManager] The single instance of [LocalizationManager] to be provided
  /// to all dependent widgets.
  LocalizationProvider({Key? key, required super.child, required this.localizationManager}) : super(key: key ?? instanceKey);

  /// Determines whether the framework should notify widgets that inherit from this widget.
  ///
  /// In this case, always returns true as any changes in the [LocalizationManager] should
  /// trigger updates in dependent widgets.
  @override
  bool updateShouldNotify(LocalizationProvider oldWidget) {
    return true;
  }

  /// Provides access to the nearest [LocalizationManager] up the widget tree.
  ///
  /// Throws [FlutterError] if no [LocalizationProvider] is found in the widget tree,
  /// ensuring that usage of the localization functionalities cannot proceed without a
  /// properly configured provider.
  ///
  /// [context] The build context which will be used to look up the [LocalizationProvider].
  static LocalizationManager of(BuildContext? context) {
    final LocalizationProvider? result;

    if (context != null) {
      result = context.dependOnInheritedWidgetOfExactType<LocalizationProvider>();
    } else {
      {
        result = instanceKey.currentContext?.dependOnInheritedWidgetOfExactType<LocalizationProvider>();
      }
    }

    if (result == null) {
      throw FlutterError('LocalizationProvider not found in context');
    }

    return result.localizationManager;
  }
}
