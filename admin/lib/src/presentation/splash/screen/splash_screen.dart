import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:coffee_admin/injection.dart';
import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/function/custom_toast.dart';
import '../../../core/services/bloc/service_bloc.dart';
import '../../../core/services/bloc/service_event.dart';
import '../../../core/utils/constants/constants.dart';
import '../../../data/models/preferences_model.dart';
import '../../../data/models/store.dart';
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
            customToast(context, "no_internet_connection".translate(context));
          }
        } else {
          ApiService apiService = getIt<ApiService>();
          final storeResponse = apiService.getAllStores();

          PreferencesModel preferencesModel = PreferencesModel(
            token: "",
            listStore: (await storeResponse)
                .data
                .map((e) => Store.fromStoreResponse(e))
                .toList(),
          );
          if (context.mounted) {
            context.read<ServiceBloc>().add(SetDataEvent(preferencesModel));
          }
        }

        return const LoginPage();
      },
    );
  }
}
