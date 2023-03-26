import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/language/bloc/language_cubit.dart';
import 'src/language/bloc/language_state.dart';
import 'src/language/localization/app_localizations_setup.dart';
import 'src/presentation/signup/screen/signup_page.dart';

int? language;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  language = prefs.getInt('language');
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
          create: (_) => LanguageCubit(language: language),
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
              primarySwatch: Colors.blue,
              appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Color.fromRGBO(177, 40, 48, 1),
                ),
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(color: Colors.black),
                foregroundColor: Colors.black,
              ),
            ),
            home: const SignUpPage(),
          );
        },
      ),
    );
  }
}
