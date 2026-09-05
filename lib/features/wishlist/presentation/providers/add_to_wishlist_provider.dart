import 'package:flutter/foundation.dart';

import '../../../../app/get_network_caller.dart';
import '../../../../app/urls.dart';
import '../../data/models/wishlist_param.dart';

class AddToWishlistProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> addToWishList(WishlistParam param) async {
    bool isSuccess = false;
    _isLoading = true;
    notifyListeners();

    final response = await getNetworkCaller().postRequest(
      Urls.addToWishlistUrl,
      body: param.toJson(),
    );

    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _isLoading = false;
    notifyListeners();

    return isSuccess;
  }
}
