import 'package:flutter/material.dart';

import '../features/auth/presentation/screens/sign_in_screens.dart';
import '../features/auth/presentation/screens/sign_up_screens.dart';
import '../features/auth/presentation/screens/splash_screen.dart';
import '../features/auth/presentation/screens/verify_otp_screen.dart';
import '../features/category/data/models/category_model.dart';
import '../features/products/presentation/screens/product_details_screen.dart';
import '../features/products/presentation/screens/products_by_category_screen.dart';
import '../features/shared/presentation/screens/main_nav_holder_screens.dart';

class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    Widget widget = SizedBox();

    switch (settings.name) {
      case SplashScreen.name:
        widget = SplashScreen();
      case SignUpScreens.name:
        widget = SignUpScreens();
      case VerifyOtpScreen.name:
        final email = settings.arguments as String;
        widget = VerifyOtpScreen(email: email);
      case SignInScreens.name:
        widget = SignInScreens();
      case MainNavHolderScreens.name:
        widget = MainNavHolderScreens();
      case ProductsByCategoryScreen.name:
        final category = settings.arguments as CategoryModel;
        widget = ProductsByCategoryScreen(category: category);
      case ProductDetailsScreen.name:
        final productID = settings.arguments as String;
        widget = ProductDetailsScreen(productId: productID);
    }

    return MaterialPageRoute(builder: (_) => widget);
  }
}
