import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'injection.dart';
import 'src/core/services/bloc/service_bloc.dart';
import 'src/core/utils/config/app_localizations_setup.dart';
import 'src/core/utils/constants/constants.dart';
import 'src/core/utils/language/bloc/language_cubit.dart';
import 'src/core/utils/language/bloc/language_state.dart';
import 'src/presentation/splash/screen/splash_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final prefs = getIt<SharedPreferences>();
    int? language = prefs.getInt('language');
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageCubit>(
          create: (context) => LanguageCubit(language: language),
        ),
        BlocProvider<ServiceBloc>(create: (context) => getIt<ServiceBloc>()),
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
            theme: _themeData(),
            home: const SplashPage(),
          );
        },
      ),
    );
  }

  ThemeData _themeData() {
    return ThemeData(
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
    );
  }
}
