// {
// "product": {
// "_id": "681372b57aff1010848eea4c",
// },
// "user": {
// "first_name": "Meskatul",
// "last_name": "Islam",
// "avatar_url": null
// },
// "comment": "প্রমোশনাল এসমএস",
// },

class ReviewModel {
  final String? id;
  final String? productId;
  final ReviewUserModel? user;
  final String? comment;

  ReviewModel({
    this.id,
    this.productId,
    this.user,
    this.comment,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['_id'],
      productId: json['product'] is Map ? json['product']['_id'] : null,
      user: json['user'] is Map ? ReviewUserModel.fromJson(json['user']) : null,
      comment: json['comment'],
    );
  }
}

class ReviewUserModel {
  final String? firstName;
  final String? lastName;
  final String? avatarUrl;

  ReviewUserModel({
    this.firstName,
    this.lastName,
    this.avatarUrl,
  });

  factory ReviewUserModel.fromJson(Map<String, dynamic> json) {
    return ReviewUserModel(
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatarUrl: json['avatar_url'],
    );
  }

  String get fullName => '${firstName ?? ''} ${lastName ?? ''}'.trim();
}
