import 'package:flutter/cupertino.dart';

import '../../../../app/get_network_caller.dart';
import '../../../../app/urls.dart';
import '../data/models/order_model.dart';

class CreateOrderProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> createOrder(OrderModel orderModel) async {
    bool isSuccess = false;
    _isLoading = true;
    notifyListeners();

    final response = await getNetworkCaller().postRequest(
      Urls.createOrderUrl,
      body: orderModel.toJson(),
    );

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _isLoading = false;
    notifyListeners();

    return isSuccess;
  }
}
