// {
// "_id": "6a9afc0ce1c7530f491f2a4a",
// "product": {
// "_id": "6812577dea40bfc6edc673e3",
// "title": "জাভা প্রোগ্রামিং",
// "photos": [
// "https://wafilife-media.wafilife.com/uploads/2020/01/java-250x341.png"
// ],
// "current_price": 706,
// },
// },

import '../../../products/data/models/product_model.dart';

class WishlistModel {
  final String id;
  final ProductModel product;

  WishlistModel({required this.id, required this.product});

  factory WishlistModel.fromJson(Map<String, dynamic> json) {
    return WishlistModel(
      id: json['_id'],
      product: ProductModel.fromJson(json['product']),
    );
  }
}
