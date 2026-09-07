import 'package:flutter/foundation.dart';

import '../../../../app/get_network_caller.dart';
import '../../../../app/urls.dart';
import '../../data/models/update_user_params.dart';

class UpdateUserProvider extends ChangeNotifier {
  bool _updateInProgress = false;

  bool get isUpdateInProgress => _updateInProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> updateUser(UpdateUserParams params) async {
    bool isSuccess = false;
    _updateInProgress = true;
    notifyListeners();

    final response = await getNetworkCaller().patchRequest(
      Urls.getUpdateUserUrl,
      body: params.toJson(),
    );

    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _updateInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}
