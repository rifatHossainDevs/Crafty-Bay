import 'package:crafty_bay/app/providers/locale_provider.dart';
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
  final localeProvider = LocaleProvider();
  await localeProvider.init();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider.value(value: localeProvider)],
      child: const CraftyBayApp(),
    ),
  );
}
