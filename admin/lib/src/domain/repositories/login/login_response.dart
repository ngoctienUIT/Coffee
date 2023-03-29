import 'package:json_annotation/json_annotation.dart';

import '../../entities/user/user_response.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: "accessToken")
  final String accessToken;

  @JsonKey(name: "userDocumentEntity")
  final UserResponse userResponse;

  LoginResponse({required this.accessToken, required this.userResponse});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
