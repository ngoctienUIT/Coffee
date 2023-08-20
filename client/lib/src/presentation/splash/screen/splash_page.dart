import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:coffee/injection.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../main.dart';
import '../../../core/function/custom_toast.dart';
import '../../../core/services/bloc/service_bloc.dart';
import '../../../core/services/bloc/service_event.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../data/models/preferences_model.dart';
import '../../../data/models/store.dart';
import '../../../data/models/user.dart';
import '../../../data/remote/api_service/api_service.dart';
import '../../../data/remote/response/store/store_response.dart';
import '../../../data/remote/response/user/user_response.dart';
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
            customToast(context, "no_internet_connection".translate(context));
          }
          return const LoginPage();
        }
        ApiService apiService = getIt<ApiService>();
        final storeResponse = apiService.getAllStores();

        if (isLogin) {
          final prefs = getIt<SharedPreferences>();
          String token = prefs.getString("token") ?? "";
          String? userID = prefs.getString("userID");
          String? storeID = prefs.getString("storeID");
          String? address = prefs.getString("address");
          bool isBringBack = prefs.getBool("isBringBack") ?? false;

          final userResponse =
          apiService.getUserByID("Bearer $token", userID ?? "");
          final list = await Future.wait([userResponse, storeResponse]);
          PreferencesModel preferencesModel = PreferencesModel(
              token: token,
              isBringBack: isBringBack,
              address: address,
              storeID: storeID,
              user: User.fromUserResponse((list.first.data as UserResponse)),
              listStore: (list.last.data as List<StoreResponse>)
                  .map((e) => Store.fromStoreResponse(e))
                  .toList());
          if (context.mounted) {
            context.read<ServiceBloc>().add(SetDataEvent(preferencesModel));
          }
          return const MainPage(checkConnect: false);
        }
        PreferencesModel preferencesModel = PreferencesModel(
            token: "",
            listStore: (await storeResponse)
                .data
                .map((e) => Store.fromStoreResponse(e))
                .toList());
        if (context.mounted) {
          context.read<ServiceBloc>().add(SetDataEvent(preferencesModel));
        }
        return const LoginPage();
      },
    );
  }
}