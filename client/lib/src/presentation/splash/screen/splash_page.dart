import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:coffee/injection.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:coffee/src/data/local/dao/store_dao.dart';
import 'package:coffee/src/data/local/dao/user_dao.dart';
import 'package:coffee/src/data/local/entity/user_entity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../data/models/user.dart';
import '../../../data/remote/api_service/api_service.dart';
import '../../login/screen/login_page.dart';
import '../../main/screen/main_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
      splash: AppImages.imgLogo,
      splashIconSize: 250,
      screenFunction: () async {
        var connectivityResult = await Connectivity().checkConnectivity();
        if (connectivityResult == ConnectivityResult.none) {
          if (context.mounted) {
            customToast(
                context, AppLocalizations.of(context).noInternetConnection);
          }
          return const LoginPage();
        }
        ApiService apiService = getIt<ApiService>();
        final prefs = getIt<SharedPreferences>();
        bool isLogin = prefs.getBool('isLogin') ?? false;
        upsertStore();

        if (isLogin) {
          String token = prefs.getString("token") ?? "";
          String? userID = prefs.getString("userID");

          final userResponse =
              await apiService.getUserByID("Bearer $token", userID ?? "");
          upsertUser(userResponse.data.toUserEntity());
          getIt.registerLazySingleton(
              () => User.fromUserResponse(userResponse.data));
          return const MainPage(checkConnect: false);
        }
        return const LoginPage();
      },
    );
  }

  Future upsertStore() async {
    ApiService apiService = getIt<ApiService>();
    StoreDao storeDao = getIt<StoreDao>();
    final numberStore = await storeDao.getNumberStore();
    if (numberStore == null || numberStore == 0) {
      final storeResponse = await apiService.getAllStores();
      storeDao.insertListStore(
          storeResponse.data.map((e) => e.toStoreEntity()).toList());
    }
  }

  Future upsertUser(UserEntity user) async {
    UserDao userDao = getIt<UserDao>();
    final data = await userDao.findUserById(user.id).first;
    if (data == null) {
      userDao.insertUser(user);
    } else {
      userDao.updateUser(user);
    }
  }
}
