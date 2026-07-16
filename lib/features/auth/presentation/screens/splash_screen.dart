import 'package:crafty_bay/app/app_colors.dart';
import 'package:crafty_bay/app/extension/localization_extension.dart';
import 'package:crafty_bay/app/providers/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              SizedBox(height: 8),
              LocalChangerDropdown(),
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

class LocalChangerDropdown extends StatelessWidget {
  const LocalChangerDropdown({super.key});

  String getLanguage(Locale locale) {
    switch (locale.languageCode) {
      case "en":
        return "English";
      case "bn":
        return "বাংলা";
      case "de":
        return "Deutsch";
      case "es":
        return "Español";
      default:
        return locale.languageCode.toUpperCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, localProvider, _) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.themeColor,
            borderRadius: .circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .08),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<Locale>(
              elevation: 12,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              dropdownColor: AppColors.themeColor,
              icon: Icon(Icons.arrow_drop_down, color: Colors.white),
              value: localProvider.currentLocale,
              items: localProvider.supportedLocales.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Row(
                    children: [
                      const Icon(Icons.language, color: Colors.white, size: 20),
                      const SizedBox(width: 12),
                      Text(getLanguage(e)),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (Locale? newLocal) {
                if (newLocal != null) {
                  localProvider.changeLocale(newLocal);
                }
              },
            ),
          ),
        );
      },
    );
  }
}
