import 'package:coffee/src/data/repositories/login_repository_impl.dart';
import 'package:coffee/src/domain/repositories/login_repository.dart';
import 'package:coffee/src/domain/use_cases/login_use_case/login_email_password.dart';
import 'package:coffee/src/domain/use_cases/login_use_case/login_google.dart';
import 'package:coffee/src/presentation/login/bloc/login_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/data/remote/api_service/api_service.dart';

final getIt = GetIt.instance;

Future initDependencies() async {
  await _initSharedPreferences();

  getIt.registerSingleton<Dio>(
      Dio(BaseOptions(contentType: "application/json")));

  getIt.registerSingleton<ApiService>(ApiService(getIt()));

  getIt.registerSingleton<LoginRepository>(
      LoginRepositoryImpl(getIt(), getIt()));

  getIt.registerSingleton<LoginGoogleUseCase>(LoginGoogleUseCase(getIt()));

  getIt.registerSingleton<LoginEmailPasswordUseCase>(
      LoginEmailPasswordUseCase(getIt()));

  getIt.registerFactory(() => LoginBloc(getIt(), getIt()));
}

Future _initSharedPreferences() async {
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPref);
}
