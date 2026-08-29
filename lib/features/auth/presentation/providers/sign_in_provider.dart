import 'package:flutter/foundation.dart';

import '../../../../app/get_network_caller.dart';
import '../../../../app/providers/auth_controller.dart';
import '../../../../app/urls.dart';
import '../../../../core/services/network_caller/network_caller.dart';
import '../../data/models/sign_in_params.dart';
import '../../data/models/user_model.dart';

class SignInProvider extends ChangeNotifier {
  bool _signInInProgress = false;

  String? _errorMessage;

  bool get isSignInInProgress => _signInInProgress;

  String? get errorMessage => _errorMessage;

  Future<bool> signIn(SignInParams params) async {
    bool isSuccess = false;
    _signInInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().postRequest(
      Urls.signInUrl,
      body: params.toJson(),
    );

    if (response.isSuccess) {
      // User data + token save in local database
      String token = response.body['data']['token'];
      UserModel userModel = UserModel.fromJson(response.body['data']['user']);

      // save user data in local database
      await AuthController.saveUserData(userModel, token);
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _signInInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}
