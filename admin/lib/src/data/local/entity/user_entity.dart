import 'package:floor/floor.dart';

import '../../models/user.dart';

@Entity(tableName: "User")
class UserEntity {
  @primaryKey
  final String id;

  @ColumnInfo(name: "username")
  final String username;

  @ColumnInfo(name: "displayName")
  final String displayName;

  @ColumnInfo(name: "isMale")
  final bool isMale;

  @ColumnInfo(name: "birthOfDate")
  final String birthOfDate;

  @ColumnInfo(name: "email")
  final String email;

  @ColumnInfo(name: "phoneNumber")
  final String phoneNumber;

  @ColumnInfo(name: "hashedPassword")
  final String hashedPassword;

  @ColumnInfo(name: "imageUrl")
  final String imageUrl;

  @ColumnInfo(name: "userRole")
  final String userRole;

  @ColumnInfo(name: "provider")
  final String provider;

  @ColumnInfo(name: "google")
  final String google;

  UserEntity(
    this.id,
    this.username,
    this.displayName,
    this.isMale,
    this.birthOfDate,
    this.email,
    this.phoneNumber,
    this.hashedPassword,
    this.imageUrl,
    this.userRole,
    this.provider,
    this.google,
  );

  User toUser() {
    return User(
      id: id,
      username: username,
      displayName: displayName,
      isMale: isMale,
      email: email,
      phoneNumber: phoneNumber,
      password: hashedPassword,
      birthOfDate: birthOfDate,
      imageUrl: imageUrl,
      userRole: userRole,
    );
  }
}
