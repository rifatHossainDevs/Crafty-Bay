class ShippingAddressModel {
  final String name;
  final String address;
  final String city;
  final String postalCode;
  final String phone;

  ShippingAddressModel({
    required this.name,
    required this.address,
    required this.city,
    required this.postalCode,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'city': city,
      'postal_code': postalCode,
      'phone': phone,
    };
  }
}
