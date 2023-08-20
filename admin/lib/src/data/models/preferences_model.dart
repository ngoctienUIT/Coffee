import 'package:dio/dio.dart';

import '../remote/api_service/api_service.dart';
import 'store.dart';
import 'user.dart';

class PreferencesModel {
  String token;
  User? user;
  List<Store> listStore;
  List<User> listUser;
  ApiService apiService =
      ApiService(Dio(BaseOptions(contentType: "application/json")));

  PreferencesModel({
    this.token = "",
    this.user,
    this.listStore = const [],
    this.listUser = const [],
  });

  PreferencesModel copyWith({
    String? token,
    User? user,
    List<User>? listUser,
    List<Store>? listStore,
  }) {
    return PreferencesModel(
      token: token ?? this.token,
      user: user ?? this.user,
      listUser: listUser ?? this.listUser,
      listStore: listStore ?? this.listStore,
    );
  }

  User? getUser(String id) {
    int index = listUser.indexWhere((element) => element.id == id);
    if (index > -1) return listUser[index];
    return null;
  }
}
