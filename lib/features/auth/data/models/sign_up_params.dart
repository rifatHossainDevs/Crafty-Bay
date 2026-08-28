class SignUpParams {
  final String email;
  final String firstName;
  final String lastName;
  final String phone;
  final String password;
  final String city;

  SignUpParams({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.city,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'city': city,
      'password': password,
    };
  }
}
