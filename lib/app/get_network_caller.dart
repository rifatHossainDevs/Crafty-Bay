import 'package:crafty_bay/app/crafty_bay_app.dart';
import 'package:crafty_bay/app/providers/auth_controller.dart';
import 'package:flutter/cupertino.dart';

import '../core/services/network_caller/network_caller.dart';
import '../features/auth/presentation/screens/sign_in_screens.dart';

NetworkCaller getNetworkCaller() {
  return NetworkCaller(
    headers: () => {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (AuthController.accessToken != null)
        'token': AuthController.accessToken!,
    },
    onUnauthorized: () {
      AuthController.clearUserData();
      Navigator.pushNamed(
        CraftyBayApp.navigatorKey.currentContext!,
        SignInScreens.name,
      );
    },
  );
}
