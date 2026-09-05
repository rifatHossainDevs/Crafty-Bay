import 'package:flutter/foundation.dart';

import '../../../../app/get_network_caller.dart';
import '../../../../app/urls.dart';
import '../data/models/add_review_params.dart';

class AddReviewProvider extends ChangeNotifier {
  bool _isReviewInProgress = false;

  bool get isReviewInProgress => _isReviewInProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> addReview(AddReviewParams addReviewParams) async {
    bool isSuccess = false;
    _isReviewInProgress = true;
    notifyListeners();

    final response = await getNetworkCaller().postRequest(
      Urls.createReviewUrl,
      body: addReviewParams.toJson(),
    );

    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _isReviewInProgress = false;
    notifyListeners();
    return isSuccess;
  }
}
