import 'package:localization_pro/localization_provider.dart';

/// Main entry point of the application.
/// Initializes the localization manager with supported locales and translations.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
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

  // Run the application with the localization provider.
  runApp(LocalizationProvider(
      supportedTranslations: supportedTranslations,
      initialLocale: const Locale('uz', 'UZ'),
      initialTranslations: const ['1'],
      debugMode: true,
      child: const MyApp()));
}

/// The root widget of the application.
///
/// Provides a [LocalizationProvider] to manage localization throughout the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Dynamic Localization Demo',
      home: HomeScreen(),
    );
  }
}

/// Home screen of the application displaying various localized texts and controls to change language.
///
/// Provides interactive elements to test dynamic localization functionality such as adding,
/// removing translations, and changing the locale.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Helper function to create buttons for adding or removing translations.
    Widget returnAddOrRemoveButton(String name, {bool isAdd = true}) {
      return TextButton(
          onPressed: () {
            if (isAdd) {
              context.reloadTranslations();
              context.reloadTranslation(name);
              context.addTranslation(name);
            } else {
              context.removeTranslation(name);
            }
          },
          child: Text('${isAdd ? '+' : '-'} $name'));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'app_title'.tr(context)), // Translated title from current locale.
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('(1) Title: ${'title'.tr()}'), // Translated strings.
            Text('(1) ${'make.plove.not.war'.tr()}'), // Translated strings.
            Text('(1) ${tr('one.a.b.c', namedArgs: {'name': "Shavkat"})}'),
            const SizedBox(height: 20),
            Text('(2) ${'two'.tr()}'),
            Text('(2) ${tr('money', count: 3, namedArgs: {'name': "Salom"})}'),

            const SizedBox(height: 40),
            Text('adding'.tr()), // Section title.
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                returnAddOrRemoveButton('1'),
                returnAddOrRemoveButton('2'),
              ],
            ),
            const SizedBox(height: 20),
            Text('removing'.tr()), // Section title.
            // Buttons for removing translations.
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                returnAddOrRemoveButton('1', isAdd: false),
                returnAddOrRemoveButton('2', isAdd: false),
              ],
            ),
            const SizedBox(height: 40),
            // Buttons to change the entire application's locale.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () =>
                      context.changeLocale(const Locale('uz', 'UZ')),
                  child: Text('uzbek'.tr()),
                ),
                ElevatedButton(
                  onPressed: () =>
                      context.changeLocale(const Locale('en', 'US')),
                  child: Text('english'.tr()),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
