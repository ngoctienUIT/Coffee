import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  @JsonKey(name: "userId")
  final String id;

  @JsonKey(name: "username")
  final String username;

  @JsonKey(name: "displayName")
  final String displayName;

  @JsonKey(name: "isMale")
  final bool isMale;

  @JsonKey(name: "email")
  final String email;

  @JsonKey(name: "birthOfDate")
  final String? birthOfDate;

  @JsonKey(name: "phoneNumber")
  final String phoneNumber;

  @JsonKey(name: "hashedPassword")
  final String hashedPassword;

  @JsonKey(name: "imageUrl")
  final String? imageUrl;

  @JsonKey(name: "userRole")
  final String userRole;

  @JsonKey(name: "accountProvider")
  final String? accountProvider;

  @JsonKey(name: "accountProviderReferenceUid")
  final String? accountProviderReferenceUid;

  UserResponse({
    required this.id,
    required this.username,
    required this.displayName,
    required this.isMale,
    required this.email,
    required this.phoneNumber,
    required this.hashedPassword,
    this.birthOfDate,
    this.imageUrl,
    required this.userRole,
    required this.accountProvider,
    this.accountProviderReferenceUid,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
