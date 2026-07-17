import 'package:crafty_bay/app/providers/locale_provider.dart';
import 'package:crafty_bay/app/providers/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/crafty_bay_app.dart';
import 'firebase_options.dart';

// Initialization FVM -> Done
// Folder structure -> Done
// Firebase Set up -> Done
// Crashlytics -> Done
// Analytics -> Done
// Theming -> Done
// Localization -> Done
// Provider -> Done

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  final LocaleProvider localeProvider = LocaleProvider();
  final ThemeProvider themeProvider = ThemeProvider();
  await localeProvider.init();
  await themeProvider.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: localeProvider),
        ChangeNotifierProvider.value(value: themeProvider),
      ],
      child: const CraftyBayApp(),
    ),
  );
}
