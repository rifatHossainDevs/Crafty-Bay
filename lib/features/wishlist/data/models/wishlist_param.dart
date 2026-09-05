// {
// "product":"6812577dea40bfc6edc673e3"
// }

class WishlistParam {
  final String productId;

  WishlistParam({required this.productId});

  Map<String, dynamic> toJson() {
    return {
      'product': productId,
    };
  }

}
