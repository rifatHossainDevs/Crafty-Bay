import 'package:crafty_bay/app/routes.dart';
import 'package:crafty_bay/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../features/auth/presentation/screens/splash_screen.dart';
import 'app_theme.dart';

class CraftyBayApp extends StatefulWidget {
  const CraftyBayApp({super.key});

  @override
  State<CraftyBayApp> createState() => _CraftyBayAppState();
}

class _CraftyBayAppState extends State<CraftyBayApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Crafty Bay",
      initialRoute: SplashScreen.name,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      theme: AppTheme.lightTheme,
      localizationsDelegates: [ // Add this line
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("en"),
        Locale("bn"),
        Locale("de"),
        Locale("es"),
      ],
      locale: Locale('bn'),
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
    );
  }
}
