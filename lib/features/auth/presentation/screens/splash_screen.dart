import 'package:crafty_bay/app/extension/localization_extension.dart';
import 'package:crafty_bay/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../widgets/app_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {

    final localization = context.localization;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Spacer(),
              AppLogo(width: 120, height: 120),
              Spacer(),
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(localization.version),
            ],
          ),
        ),
      ),
    );
  }
}
