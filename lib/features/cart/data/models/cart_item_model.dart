import '../../../products/data/models/product_model.dart';

class CartItemModel {
  final String id;
  final ProductModel product;
  final String user;
  final int quantity;
  final String? color;
  final String? size;

  CartItemModel({
    required this.id,
    required this.product,
    required this.user,
    required this.quantity,
    required this.color,
    required this.size,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['_id'],
      product: ProductModel.fromJson(json['product']),
      user: json['user'],
      quantity: json['quantity'],
      color: json['color'],
      size: json['size'],
    );
  }
}
