import 'package:flutter/foundation.dart';

import '../../../../app/get_network_caller.dart';
import '../../../../app/urls.dart';
import '../../data/models/cart_item_model.dart';

class CartItemProvider extends ChangeNotifier {
  bool _cartLoading = true;

  bool get cartLoading => _cartLoading;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  List<CartItemModel> _cartItem = [];

  List<CartItemModel> get cartItem => _cartItem;

  Future<void> getCartItems() async {
    _cartLoading = true;
    notifyListeners();

    final response = await getNetworkCaller().getRequest(Urls.getCartItemsUrl);

    if (response.isSuccess) {
      _cartItem = (response.body['data']['results'] as List)
          .map((cartItem) => CartItemModel.fromJson(cartItem))
          .toList();
    } else {
      _errorMessage = response.errorMessage;
    }

    _cartLoading = false;
    notifyListeners();
  }
}
