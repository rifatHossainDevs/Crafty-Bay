class AddReviewParams {
  final String productId;
  final String comment;
  final String rating;

  AddReviewParams({
    required this.productId,
    required this.comment,
    required this.rating,
  });

  Map<String, dynamic> toJson() {
    return {
      "product": productId,
      "comment": comment,
      "rating": rating,
    };
  }
}
