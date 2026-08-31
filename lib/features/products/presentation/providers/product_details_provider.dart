import 'package:flutter/cupertino.dart';

import '../../../../app/get_network_caller.dart';
import '../../../../app/urls.dart';
import '../../data/models/product_details_model.dart';

class ProductDetailsProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  ProductDetailsModel? _productDetailsModel;

  ProductDetailsModel? get productDetailsModel => _productDetailsModel;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<void> getProductDetails(String productId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final response = await getNetworkCaller().getRequest(
      Urls.getProductDetailsUrl(productId),
    );

    if (response.isSuccess) {
      _productDetailsModel = ProductDetailsModel.fromJson(
        response.body['data'],
      );
    } else {
      _errorMessage = response.errorMessage;
    }

    _isLoading = false;
    notifyListeners();
  }
}
