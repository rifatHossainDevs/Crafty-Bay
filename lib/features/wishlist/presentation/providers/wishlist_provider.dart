import 'package:crafty_bay/features/wishlist/data/models/wishlist_model.dart';
import 'package:flutter/cupertino.dart';

import '../../../../app/get_network_caller.dart';
import '../../../../app/urls.dart';

class WishlistProvider extends ChangeNotifier {
  int _pageNo = 0;

  final int _pageSize = 20;

  int? _lastPage;

  bool _initialLoading = false;

  bool get initialLoading => _initialLoading;

  bool _isLoadingMore = false;

  bool get isLoadingMore => _isLoadingMore;

  List<WishlistModel> _wishListProducts = [];

  List<WishlistModel> get wishListProducts => _wishListProducts;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<void> getWishListProducts() async {
    if (_lastPage != null && _pageNo > _lastPage!) {
      return;
    }

    _pageNo++;

    if (_isInitialLoading) {
      _initialLoading = true;
    } else {
      _isLoadingMore = true;
    }
    notifyListeners();

    final response = await getNetworkCaller().getRequest(
      Urls.getWishListProductsUrl(_pageNo, _pageSize),
    );

    if (response.isSuccess) {
      _lastPage ??= response.body['data']['_last_page'];
      List<WishlistModel> newProducts = [];

      for (var product in response.body['data']['results']) {
        newProducts.add(WishlistModel.fromJson(product));
      }

      _wishListProducts.addAll(newProducts);

      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    if (_isInitialLoading) {
      _initialLoading = false;
    } else {
      _isLoadingMore = false;
    }
    notifyListeners();
  }

  bool get _isInitialLoading => _pageNo == 1;

  bool get isLoading => _initialLoading || _isLoadingMore;

  void refreshWishlistProductList() {
    _pageNo = 0;
    _lastPage = null;
    _wishListProducts.clear();
    getWishListProducts();
  }

  bool isProductInWishlist(String productId) {
    return _wishListProducts.any((item) => item.product.id == productId);
  }
}
