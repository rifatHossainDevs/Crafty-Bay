import 'package:flutter/foundation.dart';

import '../../../../app/get_network_caller.dart';
import '../../../../app/providers/auth_controller.dart';
import '../../../../app/urls.dart';
import '../../../../core/services/network_caller/network_caller.dart';
import '../../data/models/user_model.dart';
import '../../data/models/verify_otp_params.dart';

class VerifyOtpProvider extends ChangeNotifier {
  bool _verifyOtpInProgress = false;

  bool get isVerifyOtpInProgress => _verifyOtpInProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> verifyOtp(VerifyOtpParams params) async {
    bool isSuccess = false;
    _verifyOtpInProgress = true;
    notifyListeners();
    final NetworkResponse response = await getNetworkCaller().postRequest(
      Urls.verifyOtpUrl,
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

    _verifyOtpInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}
