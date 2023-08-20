import 'package:coffee/injection.config.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/data/remote/api_service/api_service.dart';
import 'src/data/remote/firebase/firebase_service.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future configureDependencies() async => await getIt.init();

@module
abstract class InjectionModule {
  @lazySingleton
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  // @lazySingleton
  // Dio get dio => Dio(BaseOptions(contentType: "application/json"));

  @lazySingleton
  ApiService get apiService =>
      ApiService(Dio(BaseOptions(contentType: "application/json")));

  @lazySingleton
  FirebaseService get firebaseService =>
      FirebaseService(Dio(BaseOptions(contentType: "application/json")));
}
