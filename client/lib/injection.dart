import 'package:coffee/injection.config.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/data/remote/api_service/api_service.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future configureDependencies() async => await getIt.init();

@module
abstract class InjectionModule {
  @singleton
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  // @singleton
  // Dio get dio => Dio(BaseOptions(contentType: "application/json"));

  @singleton
  ApiService get apiService =>
      ApiService(Dio(BaseOptions(contentType: "application/json")));
}
