/// Exports of the Localization Pro package.
///
/// This file consolidates exports from various modules of the Localization Pro
/// package, simplifying the import process for end-users and maintaining a cleaner
/// architecture. By importing this single file, users can access all necessary
/// components required for managing and applying localizations in their Flutter applications.
library;

export 'package:flutter/material.dart';
// Exporting extensions that enhance BuildContext and String with localization capabilities.
export 'package:localization_pro/src/extensions/extensions.dart';
// Exporting the core manager that handles all localization logic.
export 'package:localization_pro/src/manager/localization_manager.dart';
// Exporting models that represent the data structures used for localization.
export 'package:localization_pro/src/models/models.dart';
// Exporting the provider that facilitates access to the LocalizationManager via InheritedWidget.
export 'package:localization_pro/src/provider/provider.dart';
// Exporting the helpers to use in project
export 'package:localization_pro/src/helpers/helpers.dart';
