import 'package:crafty_bay/app/get_network_caller.dart';
import 'package:crafty_bay/app/urls.dart';
import 'package:flutter/cupertino.dart';

import '../../data/models/add_to_cart_params.dart';

class AddToCartProvider extends ChangeNotifier {
  bool _addToCartInProgress = false;

  bool get addToCartInProgress => _addToCartInProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> addToCart(AddToCartParams params) async {
    bool isSuccess = false;
    _addToCartInProgress = true;
    notifyListeners();

    final response = await getNetworkCaller().postRequest(
      Urls.addToCartUrl,
      body: params.toJson(),
    );

    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _addToCartInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}
