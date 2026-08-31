class ProductModel {
  final String id;
  final String title;
  final List<String> photos;
  final int currentPrice;
  final int quantity;
  final double rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.photos,
    required this.currentPrice,
    required this.quantity,
    required this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'],
      title: json['title'],
      photos: List.from(json['photos']),
      currentPrice: json['current_price'],
      quantity: json['quantity'],
      rating: 4.5,
    );
  }
}
