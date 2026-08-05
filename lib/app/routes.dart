import 'package:crafty_bay/features/auth/presentation/screens/sign_in_screens.dart';
import 'package:crafty_bay/features/auth/presentation/screens/verify_otp_screen.dart';
import 'package:crafty_bay/features/products/presentation/screens/products_by_category_screen.dart';
import 'package:crafty_bay/features/shared/presentation/screens/main_nav_holder_screens.dart';
import 'package:flutter/material.dart';

import '../features/auth/presentation/screens/sign_up_screens.dart';
import '../features/auth/presentation/screens/splash_screen.dart';

class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    Widget widget = SizedBox();

    switch (settings.name) {
      case SplashScreen.name:
        widget = SplashScreen();
      case SignUpScreens.name:
        widget = SignUpScreens();
      case VerifyOtpScreen.name:
        widget = VerifyOtpScreen();
      case SignInScreens.name:
        widget = SignInScreens();
      case MainNavHolderScreens.name:
        widget = MainNavHolderScreens();
      case ProductsByCategoryScreen.name:
        final categoryName = settings.arguments as String;
        widget = ProductsByCategoryScreen(categoryName: categoryName);
    }

    return MaterialPageRoute(builder: (_) => widget);
  }
}
