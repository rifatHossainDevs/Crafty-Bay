import 'package:flutter/material.dart';

import '../features/auth/presentation/screens/edit_profile_screen.dart';
import '../features/auth/presentation/screens/sign_in_screens.dart';
import '../features/auth/presentation/screens/sign_up_screens.dart';
import '../features/auth/presentation/screens/splash_screen.dart';
import '../features/auth/presentation/screens/verify_otp_screen.dart';
import '../features/brands/presentation/screens/brands_screen.dart';
import '../features/category/data/models/category_model.dart';
import '../features/products/presentation/screens/product_details_screen.dart';
import '../features/products/presentation/screens/products_by_category_screen.dart';
import '../features/reviews/presentation/screens/add_new_reviews_screen.dart';
import '../features/reviews/presentation/screens/reviews_screen.dart';
import '../features/shared/presentation/screens/about_screen.dart';
import '../features/shared/presentation/screens/main_nav_holder_screens.dart';

class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    Widget widget = SizedBox();

    switch (settings.name) {
      case SplashScreen.name:
        widget = SplashScreen();
        break;
      case SignUpScreens.name:
        widget = SignUpScreens();
        break;
      case VerifyOtpScreen.name:
        final email = settings.arguments as String;
        widget = VerifyOtpScreen(email: email);
        break;
      case SignInScreens.name:
        widget = SignInScreens();
        break;
      case MainNavHolderScreens.name:
        widget = MainNavHolderScreens();
        break;
      case ProductsByCategoryScreen.name:
        final category = settings.arguments as CategoryModel;
        widget = ProductsByCategoryScreen(category: category);
        break;
      case ProductDetailsScreen.name:
        final productID = settings.arguments as String;
        widget = ProductDetailsScreen(productId: productID);
        break;
      case ReviewsScreen.name:
        final productID = settings.arguments as String;
        widget = ReviewsScreen(productId: productID,);
        break;
      case AddNewReviewsScreen.name:
        final productID = settings.arguments as String;
        widget = AddNewReviewsScreen(productId: productID,);
        break;
      case EditProfileScreen.name:
        widget = EditProfileScreen();
        break;
      case BrandsScreen.name:
        widget = BrandsScreen();
        break;
      case AboutScreen.name:
        widget = AboutScreen();
        break;
    }

    return MaterialPageRoute(builder: (_) => widget);
  }
}
