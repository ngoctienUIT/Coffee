import 'package:coffee/src/data/local/entity/user_entity.dart';
import 'package:coffee/src/data/remote/response/provider/provider_response.dart';
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

  @JsonKey(name: "birthOfDate")
  final String? birthOfDate;

  @JsonKey(name: "email")
  final String email;

  @JsonKey(name: "phoneNumber")
  final String phoneNumber;

  @JsonKey(name: "hashedPassword")
  final String hashedPassword;

  @JsonKey(name: "imageUrl")
  String? imageUrl;

  @JsonKey(name: "userRole")
  final String userRole;

  @JsonKey(name: "associatedProviders")
  final ProviderResponse? accountProvider;

  UserResponse({
    required this.id,
    required this.username,
    required this.displayName,
    required this.isMale,
    required this.email,
    required this.phoneNumber,
    required this.hashedPassword,
    this.imageUrl,
    this.birthOfDate,
    required this.userRole,
    required this.accountProvider,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);

  UserEntity toUserEntity() {
    return UserEntity(
      id,
      username,
      displayName,
      isMale,
      birthOfDate ?? "",
      email,
      phoneNumber,
      hashedPassword,
      imageUrl ?? "",
      userRole,
      accountProvider?.provider ?? "",
      accountProvider?.google ?? "",
    );
  }
}
