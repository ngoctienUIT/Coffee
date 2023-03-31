class User {
  final String username;
  final String displayName;
  final bool isMale;
  final String email;
  final String phoneNumber;
  final String password;
  final String? imageUrl;
  final String userRole;

  User({
    required this.username,
    required this.displayName,
    required this.isMale,
    required this.email,
    required this.phoneNumber,
    required this.password,
    this.imageUrl,
    required this.userRole,
  });

  Map<String, dynamic> toJson() {
    return {
      "displayName": displayName,
      "email": email,
      "phoneNumber": phoneNumber,
      "username": username,
      "hashedPassword": password,
      "userRole": userRole,
    };
  }
}
