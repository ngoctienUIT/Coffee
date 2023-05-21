import 'package:coffee/src/domain/entities/user/user_response.dart';
import 'package:equatable/equatable.dart';

import '../../domain/repositories/provider/provider_response.dart';

//ignore: must_be_immutable
class User extends Equatable {
  final String? id;
  final String username;
  String displayName;
  bool isMale;
  final String email;
  final String phoneNumber;
  String password;
  String? imageUrl;
  String userRole;
  String? birthOfDate;
  final ProviderResponse? accountProvider;

  User({
    this.id,
    required this.username,
    required this.displayName,
    required this.isMale,
    required this.email,
    required this.phoneNumber,
    required this.password,
    this.birthOfDate,
    this.imageUrl,
    this.userRole = "CUSTOMER",
    this.accountProvider,
  });

  factory User.fromUserResponse(UserResponse userResponse) {
    return User(
      id: userResponse.id,
      username: userResponse.username,
      displayName: userResponse.displayName,
      isMale: userResponse.isMale,
      email: userResponse.email,
      phoneNumber: userResponse.phoneNumber,
      password: userResponse.hashedPassword,
      userRole: userResponse.userRole,
      imageUrl: userResponse.imageUrl,
      birthOfDate: userResponse.birthOfDate,
      accountProvider: userResponse.accountProvider,
    );
  }

  User copyWith({
    String? displayName,
    bool? isMale,
    String? imageUrl,
    String? password,
    String? birthOfDate,
    bool? isAccountProvider,
  }) {
    if (isAccountProvider != null) {
      isAccountProvider
          ? accountProvider!.google = "google"
          : accountProvider!.google = null;
    }

    return User(
      id: id,
      username: username,
      displayName: displayName ?? this.displayName,
      isMale: isMale ?? this.isMale,
      email: email,
      phoneNumber: phoneNumber,
      password: password ?? this.password,
      imageUrl: imageUrl ?? this.imageUrl,
      userRole: userRole,
      birthOfDate: birthOfDate ?? this.birthOfDate,
      accountProvider: accountProvider,
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
      "birthOfDate": birthOfDate,
      "isMale": isMale,
    };
  }

  @override
  List<Object?> get props => [displayName, imageUrl, birthOfDate, isMale];
}
