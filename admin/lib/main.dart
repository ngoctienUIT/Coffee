import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:coffee_admin/src/core/services/bloc/service_bloc.dart';
import 'package:coffee_admin/src/core/utils/constants/constants.dart';
import 'package:coffee_admin/src/data/models/preferences_model.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'src/core/services/bloc/service_event.dart';
import 'src/core/services/language/bloc/language_cubit.dart';
import 'src/core/services/language/bloc/language_state.dart';
import 'src/core/services/language/localization/app_localizations_setup.dart';
import 'src/data/models/store.dart';
import 'src/domain/api_service.dart';
import 'src/presentation/login/screen/login_page.dart';

int? language;
bool isLogin = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool("isOpen", true);
  language = prefs.getInt('language');
  isLogin = prefs.getBool('isLogin') ?? false;
  FirebaseMessaging.instance.getToken().then((value) {
    print(value);
  });
  await FirebaseMessaging.instance.subscribeToTopic("orderCoffee");
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
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
            title: 'Coffee Admin',
            theme: ThemeData(
              // useMaterial3: true,
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
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
      screenFunction: () async {
        ApiService apiService =
            ApiService(Dio(BaseOptions(contentType: "application/json")));
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

        return const LoginPage();
      },
      splash: AppImages.imgLogo,
      splashIconSize: 250,
    );
  }
}
