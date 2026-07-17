import 'package:crafty_bay/app/app_colors.dart';
import 'package:crafty_bay/app/extension/localization_extension.dart';
import 'package:crafty_bay/app/providers/locale_provider.dart';
import 'package:crafty_bay/app/providers/theme_provider.dart';
import 'package:crafty_bay/app/utils.dart';
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
              SizedBox(height: 8),
              ThemeChangerDropdown(),
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

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, localProvider, _) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
              isDense: true,
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
                      Text(Utils.getLanguage(e)),
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


class ThemeChangerDropdown extends StatelessWidget {
  const ThemeChangerDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            child: DropdownButton<ThemeMode>(
              elevation: 12,
              isDense: true,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              dropdownColor: AppColors.themeColor,
              icon: Icon(Icons.arrow_drop_down, color: Colors.white),
              value: themeProvider.currentTheme,
              items: themeProvider.themeModes.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Row(
                    children: [
                      Icon(Utils.getThemeIcon(e), color: Colors.white, size: 20),
                      const SizedBox(width: 12),
                      Text(e.name.toUpperCase()),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (ThemeMode? newTheme) {
                if (newTheme != null) {
                  themeProvider.changeThemeMode(newTheme);
                }
              },
            ),
          ),
        );
      },
    );
  }
}
