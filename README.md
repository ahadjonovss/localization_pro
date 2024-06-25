
![Logo](https://firebasestorage.googleapis.com/v0/b/shaxobcha-1ac32.appspot.com/o/2024-05-19%2017.30.43.jpg?alt=media&token=f6b663d2-e326-4bdf-828f-4850659df78d)

# Localization Pro

A dynamic Flutter package for seamless localization management.

`Localization Pro` simplifies the process of adding and managing multiple languages in your Flutter applications. Designed with flexibility in mind, it supports dynamic language switching, runtime translation updates, and provides a streamlined API to enhance the localization experience. Whether you're building a small app or a large scale project, `Localization Pro` makes it easy to deliver a localized interface that adapts to your users' languages on the fly.

# Features

`Localization Pro`, developed and supported by Samandar Ahadjonov in collaboration with the Uzbekistan Flutter community, provides a robust and flexible solution for managing localizations in Flutter applications. This package is designed to cater to the specific needs of developers both globally and within the vibrant tech community of Uzbekistan. Here are some of the standout features:

## Community-Driven Development
- **Supported by Uzbekistan's Flutter Community**: This package benefits from the active involvement and support of the local Flutter community, ensuring it meets the high standards and specific needs of developers in Uzbekistan and beyond.
- **Endorsed by Samandar Ahadjonov**: As a prominent member of the Uzbekistan Flutter community, Samandar Ahadjonov’s leadership in the development of this package guarantees quality and relevance to local and international developers.

## Dynamic Localization Management
- **Real-time Language Switching**: Allows users to switch languages seamlessly at runtime without the need for restarting the app, thus enhancing user experience.
- **Dynamic Translation Loading**: Efficiently load and unload translations as needed, ideal for applications with extensive and varied localization demands.

Supported and endorsed by the local tech community and led by Samandar Ahadjonov, `Localization Pro` is your go-to solution for adding efficient, dynamic localization to your Flutter apps.

## Getting Started

Welcome to `Localization Pro`, the dynamic localization solution for Flutter apps. This guide will help you integrate `Localization Pro` into your project effortlessly.

### Step 1: Add the package to your project

First, you need to add `Localization Pro` to your project. Insert the following line into your `pubspec.yaml` under the dependencies section:

```yaml
dependencies:
  localization_pro: ^x.y.z
```
### Step 2: Install the package
After updating your pubspec.yaml, run the following command to install the package:

``` yaml
flutter pub get
```
This command fetches the package and installs it into your project.

### Step 3: Import the package
Add the following import to the Dart files where you want to use the localization features:

```yaml
import 'package:localization_pro/localization_provider.dart';
```
# Usage

The `Localization Pro` package offers comprehensive localization functionalities. Below is a guide on how to utilize all features in your Flutter application.

## Setting Up Locales and Translations

First, define the locales your application will support along with the corresponding translation files. Here's an example of how to set up supported locales and their translations:

```dart
List<SupportedTranslation> supportedTranslations = [
  SupportedTranslation(name: '1', paths: {
    const Locale('en', 'US'): 'assets/locales/en_US/1.json',
    const Locale('uz', 'UZ'): 'assets/locales/uz_UZ/1.json',
  }),
  SupportedTranslation(name: '2', paths: {
    const Locale('en', 'US'): 'assets/locales/en_US/2.json',
    const Locale('uz', 'UZ'): 'assets/locales/uz_UZ/2.json',
  }),
  SupportedTranslation(name: '3', paths: {
    const Locale('en', 'US'): 'assets/locales/en_US/3.json',
    const Locale('uz', 'UZ'): 'assets/locales/uz_UZ/3.json',
  })
];

```

Ensure your JSON translation files are structured properly and stored at the specified paths.

## Initialization in Main

``` Dart

void main(){
  // Run the app and wrap MyApp with LocalizationProvider
  runApp(LocalizationProvider(
      supportedTranslations: supportedTranslations,
      initialLocale: const Locale('uz', 'UZ'),
      initialTranslations: ['1'],
      debugMode: true,
      child: MyApp()));
}

```

# Dynamic Translation Management
To dynamically add or remove translations during runtime, you can use methods provided by the LocalizationManager through the context. For instance:

## Adding a Translation
``` Dart
context.addTranslation('settings');
```
This would load the 'settings' translation for the current locale.

## Removing a Translation
``` Dart
context.removeTranslation('settings');
```
This would unload the 'settings' translation from the current locale.

## Changing Locale
Change the application's locale dynamically and reload the necessary translations:

``` Dart
context.changeLocale(Locale('es', 'ES'));
```
This switches the application's locale to Spanish and loads the appropriate translations.

## Translating Strings
Extend the String class to use translations easily in your UI code:
```Dart
Text('home_title'.tr())
```

### Translation with Parameters:
Suppose you have a translation entry that expects a name and a date. The JSON might look like this:

```json
{
  "greeting": "Hello, {name}! Today is {date}."
}
```

#### Using trParams in Code:
You can use the trParams method to insert dynamic values into this translation:

``` dart
String greeting = 'greeting'.trParams({
  'name': 'Alice',
  'date': 'April 4th'
});
Text(greeting); // Displays: "Hello, Alice! Today is April 4th."
```

### `trPlural` Function
The `trPlural` function is used to translate text keys into their appropriate plural forms based on the given count. This function is essential for handling pluralization in different locales.

#### Parameters:
- `count`: The number used to determine the plural form of the translation.
- `context`: (Optional) The build context from which the locale is resolved. This is used to access the correct localized data.

#### Usage:

```dart
// Usage of trPlural in a Text widget for singular or plural forms based on the count.
String singleOrPlural = trPlural(1);
Text(singleOrPlural); // Displays 'item' if count is 1 or 'items' if more

// Example in a full sentence where count influences the translation
int itemCount = 3;
Text(trPlural(itemCount) + ' remaining in your cart'); // Could translate to '3 items remaining in your cart'

```


### `tr` Function
The `tr` function is designed to translate text keys into localized strings based on the current locale settings. It supports basic translation, context-based translation, dynamic string formatting with named arguments, and pluralization. This function is ideal for integrating localization directly within UI components like `Text` widgets.

#### Parameters:
- `key`: The key corresponding to the text that needs to be translated.
- `context`: (Optional) The build context from which the locale is resolved.
- `namedArgs`: (Optional) A map of named arguments used for string formatting within the translation.
- `count`: (Optional) An integer used for handling plural forms in translations.

#### Usage in `Text` Widget:

```dart
// Basic translation directly in a Text widget
Text(tr('hello'))

// Translation with context in a Text widget
Text(tr('hello', context: context))

// Translation with named arguments in a Text widget
Text(tr('welcome', namedArgs: {'name': 'Alice'}))

// Translation with pluralization in a Text widget
Text(tr('cats', count: 5))

// Combined named arguments and pluralization in a Text widget
// Useful for complex translations involving both dynamic data and plural forms.
Text(tr('party_invitation', namedArgs: {'name': 'Alice', 'numberOfGuests': '5'}, count: 5))

```


### Documentation for Handling Nested JSON Translations

#### Purpose:
Handling nested JSON structures allows your localization system to manage complex translation entries organized in a hierarchical manner.
#### Usage:

#### Nested JSON Example:
Your JSON file might contain nested keys like so:

``` json
{
  "settings": {
    "audio": {
      "volume": "Volume",
      "balance": "Balance"
    },
    "display": {
      "brightness": "Brightness",
      "contrast": "Contrast"
    }
  }
}
```

#### Fetching a Nested Translation:
Access the nested translation using dot notation:

``` dart

Text('settings.audio.volume'.tr()); // Displays: "Volume"
```

# Frequently Asked Questions (FAQ)

Here are answers to some of the most common questions about the `Localization Pro` package:

### 1. What is `Localization Pro`?
`Localization Pro` is a Flutter package designed to facilitate the easy management of multiple languages in Flutter applications, offering features like dynamic language switching and runtime translation updates.

### 2. How do I install `Localization Pro`?
Add `localization_pro` to your `pubspec.yaml` file under dependencies, and run `flutter pub get` in your terminal.

### 3. How do I use `Localization Pro` in my project?
After installation, import the package using `import 'package:localization_pro/localization_provider.dart';`, define your supported locales and translations, and use the provided APIs to manage translations and locale changes.

### 4. Can I dynamically add translations at runtime?
Yes, `Localization Pro` supports dynamic loading and unloading of translations at runtime without needing to restart the application.

### 5. How do I switch languages in my app using `Localization Pro`?
Use the `changeLocale` method provided by the `LocalizationManager` to change the language. This can be triggered by user input or any event in your application.

### 6. Does `Localization Pro` support Right-to-Left (RTL) languages?
Yes, it includes full support for RTL languages, ensuring that your application can seamlessly handle languages such as Arabic and Hebrew.

### 7. Where should I store my translation files?
Store your translation files in the `assets/locales` directory or any directory you prefer, but ensure to specify the correct path when setting up your `SupportedTranslation` instances.

### 8. What file format is used for translations?
Translations should be stored in JSON format, which allows for a structured and easily manageable way of handling localization data.

### 9. Is `Localization Pro` supported by the Uzbekistan Flutter community?
Yes, this package is developed with the support and involvement of the Uzbekistan Flutter community, ensuring it meets the specific needs and standards of both local and international developers.

### 10. How can I contribute to the development of `Localization Pro`?
Contributions are welcome! Check out the repository, submit pull requests, or report issues and feature requests on the GitHub page of the project.

### 11. What is the performance impact of using `Localization Pro`?
The package is designed to minimize performance impact through efficient caching mechanisms and dynamic loading, ensuring that localization does not negatively affect the app's performance.

### 12. How do I handle pluralizations and gender-specific translations?
`Localization Pro` currently requires manual handling of pluralizations and gender-specific translations within your JSON files, but we are looking to add more sophisticated linguistic features in future releases.

This FAQ section aims to clear up common questions and help developers get the most out of `Localization Pro`. For more detailed documentation, refer to the API reference section or the package documentation.

## Support

For support, email samandarahadjonov@gmail.com.


## License

[UMD GROUP](https://t.me/umdgroupuz)

