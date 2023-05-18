import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:coffee/src/core/function/custom_toast.dart';
import 'package:coffee/src/core/utils/constants/app_colors.dart';
import 'package:coffee/src/core/utils/constants/app_images.dart';
import 'package:coffee/src/core/utils/extensions/string_extension.dart';
import 'package:coffee/src/data/models/preferences_model.dart';
import 'package:coffee/src/presentation/login/screen/login_page.dart';
import 'package:coffee/src/presentation/main/screen/main_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'src/core/function/network_connectivity.dart';
import 'src/core/language/bloc/language_cubit.dart';
import 'src/core/language/bloc/language_state.dart';
import 'src/core/language/localization/app_localizations_setup.dart';

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
            home: const NavigatePage(),
          );
        },
      ),
    );
  }
}

class NavigatePage extends StatefulWidget {
  const NavigatePage({Key? key}) : super(key: key);

  @override
  State<NavigatePage> createState() => _NavigatePageState();
}

class _NavigatePageState extends State<NavigatePage> {
  final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;

  @override
  void initState() {
    super.initState();
    if (isLogin) {}
    _networkConnectivity.initialise();
    _networkConnectivity.myStream.listen((source) {
      print('source $source');
      switch (source) {
        case ConnectivityResult.mobile:
        case ConnectivityResult.wifi:
          customToast(
              context, "internet_connection_is_available".translate(context));
          break;
        case ConnectivityResult.none:
          customToast(context, "no_internet_connection".translate(context));
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
      screenFunction: () async {
        if (isLogin) {
          final prefs = await SharedPreferences.getInstance();
          String? token = prefs.getString("token");
          String? username = prefs.getString("username");
          String? userID = prefs.getString("userID");
          String? storeID = prefs.getString("storeID");
          String? address = prefs.getString("address");
          bool isBringBack = prefs.getBool("isBringBack") ?? false;
          PreferencesModel preferencesModel = PreferencesModel(
            token: token,
            userID: userID,
            isBringBack: isBringBack,
            address: address,
            storeID: storeID,
            username: username,
          );
          return MainPage(preferencesModel: preferencesModel);
        }
        return const LoginPage();
      },
      splash: AppImages.imgLogo,
      splashIconSize: 250,
    );
  }

  @override
  void dispose() {
    _networkConnectivity.disposeStream();
    super.dispose();
  }
}
