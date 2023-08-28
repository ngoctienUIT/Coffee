import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:coffee_admin/injection.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../data/local/dao/store_dao.dart';
import '../../../data/remote/api_service/api_service.dart';
import '../../login/screen/login_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

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
                context, AppLocalizations.of(context)!.noInternetConnection);
          }
          return const LoginPage();
        } else {
          upsertStore();
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
}
