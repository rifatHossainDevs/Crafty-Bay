import 'package:crafty_bay/app/urls.dart';
import 'package:flutter/foundation.dart';

import '../../../../app/get_network_caller.dart';
import '../../../../core/services/network_caller/network_caller.dart';
import '../../data/models/sign_up_params.dart';

class SignUpProvider extends ChangeNotifier {
  bool _signUpInProgress = false;

  String? _errorMessage;

  bool get isSignUpInProgress => _signUpInProgress;

  String? get errorMessage => _errorMessage;

  Future<bool> signUp(SignUpParams params) async {
    bool isSuccess = false;
    _signUpInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkCaller().postRequest(
      Urls.signUpUrl,
      body: params.toJson(),
    );

    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _signUpInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}
