import 'package:localization_pro/localization_provider.dart';

/// A widget that listens for reassemble events, typically during hot reloads,
/// and triggers a reload of translation data. This ensures that any changes to
/// language files are reflected immediately without needing to restart the app.
class ReassembleListener extends StatefulWidget {
  /// Creates a [ReassembleListener] that wraps a single child widget.
  ///
  /// The `child` parameter is required and should not be null.
  const ReassembleListener({super.key, required this.child});

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  State<StatefulWidget> createState() {
    return _ReassembleListenerState();
  }
}

class _ReassembleListenerState extends State<ReassembleListener> {
  /// Called when the framework is instructed to reassemble the widget,
  /// which typically happens during hot reload.
  ///
  /// This method calls `super.reassemble()` to inherit the behavior from the
  /// parent class, and then it reloads the translations by calling
  /// `context.reloadTranslations()`.
  @override
  void reassemble() {
    super.reassemble();
    context.reloadTranslations();
  }

  /// Describes the part of the user interface represented by this widget.
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
