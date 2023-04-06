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
  String? birthOfDate;

  User({
    required this.username,
    required this.displayName,
    required this.isMale,
    required this.email,
    required this.phoneNumber,
    required this.password,
    this.birthOfDate,
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
      birthOfDate: userResponse.birthOfDate,
    );
  }

  User copyWith({
    final String? displayName,
    final bool? isMale,
    final String? imageUrl,
    final String? password,
    final String? birthOfDate,
  }) {
    return User(
      username: username,
      displayName: displayName ?? this.displayName,
      isMale: isMale ?? this.isMale,
      email: email,
      phoneNumber: phoneNumber,
      password: password ?? this.password,
      imageUrl: imageUrl ?? this.imageUrl,
      userRole: userRole,
      birthOfDate: birthOfDate ?? this.birthOfDate,
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
      "birthOfDate":birthOfDate,
    };
  }
}
