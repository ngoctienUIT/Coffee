import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'main.dart';
import 'src/core/services/bloc/service_bloc.dart';
import 'src/core/services/language/bloc/language_cubit.dart';
import 'src/core/services/language/bloc/language_state.dart';
import 'src/core/services/language/localization/app_localizations_setup.dart';
import 'src/core/utils/constants/constants.dart';
import 'src/presentation/splash/screen/splash_screen.dart';

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