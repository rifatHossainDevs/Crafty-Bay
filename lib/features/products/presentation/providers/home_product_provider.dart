import 'package:flutter/foundation.dart';

import '../../../../app/get_network_caller.dart';
import '../../../../app/urls.dart';
import '../../data/models/product_model.dart';

class HomeProductProvider extends ChangeNotifier {
  List<ProductModel> popularProducts = [];
  List<ProductModel> specialProducts = [];
  List<ProductModel> newProducts = [];

  bool _loading = false;
  bool get loading => _loading;

  Future<void> getHomeProducts() async {
    _loading = true;
    notifyListeners();

    final results = await Future.wait([
      _getProducts("67c35af85e8a445235de197b"),
      _getProducts("67c35b395e8a445235de197e"),
      _getProducts("67c7bec4623a876bc4766fea"),
    ]);

    popularProducts = results[0];
    specialProducts = results[1];
    newProducts = results[2];

    _loading = false;
    notifyListeners();
  }

  Future<List<ProductModel>> _getProducts(String categoryId) async {
    final response = await getNetworkCaller().getRequest(
      Urls.getProductListByCategoryUrl(
        categoryId,
        1,
        20,
      ),
    );

    if (response.isSuccess) {
      return (response.body['data']['results'] as List)
          .map((product) => ProductModel.fromJson(product))
          .toList();
    }

    return [];
  }
}