import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:coffee/src/core/services/bloc/service_bloc.dart';
import 'package:coffee/src/core/services/bloc/service_event.dart';
import 'package:coffee/src/core/utils/constants/app_colors.dart';
import 'package:coffee/src/core/utils/constants/app_images.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/data/models/preferences_model.dart';
import 'package:coffee/src/data/remote/response/store/store_response.dart';
import 'package:coffee/src/presentation/login/screen/login_page.dart';
import 'package:coffee/src/presentation/main/screen/main_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'src/core/function/custom_toast.dart';
import 'src/core/services/language/bloc/language_cubit.dart';
import 'src/core/services/language/bloc/language_state.dart';
import 'src/core/services/language/localization/app_localizations_setup.dart';
import 'src/data/models/store.dart';
import 'src/data/models/user.dart';
import 'src/data/remote/api_service/api_service.dart';
import 'src/data/remote/response/user/user_response.dart';

int? language;
bool isLogin = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final prefs = await SharedPreferences.getInstance();
  language = prefs.getInt('language');
  isLogin = prefs.getBool('isLogin') ?? false;
  String? timeLogin = prefs.getString('timeLogin');
  if (isLogin &&
      timeLogin != null &&
      timeLogin.toDateTime().compareTo(DateTime.now()) <= 0) {
    isLogin = false;
    GoogleSignIn().signOut();
    SharedPreferences.getInstance().then((value) {
      value.setBool("isLogin", false);
      value.setString("storeID", "");
      value.setBool("isBringBack", false);
    });
  }
  FirebaseMessaging.instance.getToken().then((value) {
    print(value);
  });
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageCubit>(
          create: (context) => LanguageCubit(language: language),
        ),
        BlocProvider<ServiceBloc>(create: (context) => ServiceBloc()),
      ],
      child: BlocBuilder<LanguageCubit, LanguageState>(
        buildWhen: (previous, current) => previous != current,
        builder: (_, settingState) {
          return MaterialApp(
            supportedLocales: AppLocalizationsSetup.supportedLocales,
            localizationsDelegates:
                AppLocalizationsSetup.localizationsDelegates,
            localeResolutionCallback:
                AppLocalizationsSetup.localeResolutionCallback,
            locale: settingState.locale,
            debugShowCheckedModeBanner: false,
            title: 'Coffee',
            theme: ThemeData(
              fontFamily: "Roboto",
              dialogTheme: DialogTheme(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              primarySwatch: Colors.blue,
              cardTheme: CardTheme(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: AppColors.statusBarColor,
                ),
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(color: Colors.black),
                foregroundColor: Colors.black,
              ),
            ),
            home: const SplashPage(),
          );
        },
      ),
    );
  }
}

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
        ApiService apiService =
            ApiService(Dio(BaseOptions(contentType: "application/json")));
        final storeResponse = apiService.getAllStores();

        if (isLogin) {
          final prefs = await SharedPreferences.getInstance();
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
