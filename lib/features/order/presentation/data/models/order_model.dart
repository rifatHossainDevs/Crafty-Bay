import 'package:crafty_bay/features/order/presentation/data/models/shipping_address_model.dart';

class OrderModel {
  final String paymentMethod = 'ssl';
  ShippingAddressModel shippingAddressModel;
  String redirectUrl = 'https://jsonplaceholder.typicode.com/posts';

  OrderModel({required this.shippingAddressModel});

  Map<String, dynamic> toJson() {
    return {
      'payment_method': paymentMethod,
      'shipping_address': shippingAddressModel.toJson(),
      'redirect_url': redirectUrl,
    };
  }
}
