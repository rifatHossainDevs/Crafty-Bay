import 'package:flutter/foundation.dart';

import '../../../../app/get_network_caller.dart';
import '../../../../app/urls.dart';
import '../../data/models/brands_model.dart';

class BrandProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<BrandsModel> _brands = [];

  List<BrandsModel> get brands => _brands;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<void> fetchBrands() async {
    _isLoading = true;
    notifyListeners();

    final response = await getNetworkCaller().getRequest(Urls.getBrandsUrl);

    if (response.isSuccess) {
      _brands = (response.body['data']['results'] as List)
          .map((e) => BrandsModel.fromJson(e))
          .toList();
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _isLoading = false;
    notifyListeners();
  }
}
