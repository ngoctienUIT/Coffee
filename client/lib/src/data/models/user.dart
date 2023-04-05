import 'package:coffee/src/domain/entities/user/user_response.dart';

class User {
  final String username;
  String displayName;
  bool isMale;
  final String email;
  final String phoneNumber;
  String password;
  String? imageUrl;
  String userRole;

  User({
    required this.username,
    required this.displayName,
    required this.isMale,
    required this.email,
    required this.phoneNumber,
    required this.password,
    this.imageUrl,
    this.userRole = "CUSTOMER",
  });

  factory User.fromUserResponse(UserResponse userResponse) {
    return User(
      username: userResponse.username,
      displayName: userResponse.displayName,
      isMale: userResponse.isMale,
      email: userResponse.email,
      phoneNumber: userResponse.phoneNumber,
      password: userResponse.hashedPassword,
      userRole: userResponse.userRole,
      imageUrl: userResponse.imageUrl,
    );
  }

  User copyWith({
    final String? displayName,
    final bool? isMale,
    final String? email,
    final String? phoneNumber,
    final String? imageUrl,
    final String? password,
  }) {
    return User(
      username: username,
      displayName: displayName ?? this.displayName,
      isMale: isMale ?? this.isMale,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      imageUrl: imageUrl ?? this.imageUrl,
      userRole: userRole,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "displayName": displayName,
      "email": email,
      "phoneNumber": phoneNumber,
      "username": username,
      "imageUrl": imageUrl,
      "hashedPassword": password,
      "userRole": userRole,
    };
  }
}
