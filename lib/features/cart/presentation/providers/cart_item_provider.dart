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

  Future<bool> getCartItems() async {
    bool isSuccess = false;
    _cartLoading = false;
    notifyListeners();

    final response = await getNetworkCaller().getRequest(Urls.getCartItemsUrl);

    if (response.isSuccess) {
      _cartItem = (response.body['data']['results'] as List)
          .map((cartItem) => CartItemModel.fromJson(cartItem))
          .toList();
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _cartLoading = false;
    notifyListeners();

    return isSuccess;
  }

  double totalPrice() {
    double totalPrice = 0;
    for (var item in _cartItem) {
      totalPrice += item.product.currentPrice * item.quantity;
    }
    return totalPrice;
  }

  void increaseProductQuantity(int quantity, String productId) {
    for (var item in _cartItem) {
      if (item.id == productId) {
        item.quantity = quantity;
        break;
      }
    }
    notifyListeners();
  }
}
