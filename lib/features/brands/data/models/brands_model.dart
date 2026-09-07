class BrandsModel {
  final String title;
  final String description;
  final String icon;

  BrandsModel({required this.title, required this.description, required this.icon});

  factory BrandsModel.fromJson(Map<String, dynamic> json) {
    return BrandsModel(
      title: json['title'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}