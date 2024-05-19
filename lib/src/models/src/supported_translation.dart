/// Represents a single translation resource for a specific locale.
///
/// This class encapsulates the details necessary to identify and locate the translation
/// files or resources within the system. It is used by the `LocalizationManager` to load
/// the necessary translations for the given locale.
class SupportedTranslation {
  /// The name of the translation.
  ///
  /// This is typically used as an identifier for the translation within the system
  /// and may be used for logging or debugging purposes. It can also serve as a human-readable
  /// descriptor of the translation's contents or purpose.
  final String name;

  /// The path to the translation file or resource.
  ///
  /// This should be a relative or absolute path pointing to the file that contains
  /// the translation data. This path is used by the localization system to load the translation
  /// content into the application. Ensure that the path is correctly formatted and accessible
  /// from the application's runtime environment.
  final String path;

  /// Constructs a SupportedTranslation with specified name and path.
  ///
  /// This constructor requires all parameters to be provided and ensures that each
  /// translation is fully specified before use. Both parameters are marked as required,
  /// indicating that a SupportedTranslation cannot be created without them.
  ///
  /// [name] specifies the identifier for the translation, and [path] provides the location
  /// of the translation data within the filesystem or project structure.
  SupportedTranslation({required this.name, required this.path});
}
