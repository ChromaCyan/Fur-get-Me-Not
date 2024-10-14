class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String token;
  final String role;
  final String? profileImage;
  final String? address;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.token,
    required this.role,
    this.profileImage,
    this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      token: json['token'],
      role: json['role'],
      profileImage: json['profileImage'],
      address: json['address'],
    );
  }
}
