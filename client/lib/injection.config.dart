// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:coffee/injection.dart' as _i14;
import 'package:coffee/src/data/remote/api_service/api_service.dart' as _i3;
import 'package:coffee/src/data/repositories/login_repository_impl.dart' as _i8;
import 'package:coffee/src/data/repositories/signup_repository_impl.dart'
    as _i6;
import 'package:coffee/src/domain/repositories/login_repository.dart' as _i7;
import 'package:coffee/src/domain/repositories/signup_repository.dart' as _i5;
import 'package:coffee/src/domain/use_cases/login_use_case/login_email_password.dart'
    as _i10;
import 'package:coffee/src/domain/use_cases/login_use_case/login_google.dart'
    as _i11;
import 'package:coffee/src/domain/use_cases/signup_use_case/signup_email_password.dart'
    as _i9;
import 'package:coffee/src/presentation/login/bloc/login_bloc.dart' as _i13;
import 'package:coffee/src/presentation/signup/bloc/signup_bloc.dart' as _i12;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i4;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectionModule = _$InjectionModule();
    gh.singleton<_i3.ApiService>(injectionModule.apiService);
    await gh.singletonAsync<_i4.SharedPreferences>(
      () => injectionModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i5.SignupRepository>(
        () => _i6.SignupRepositoryImpl(gh<_i3.ApiService>()));
    gh.lazySingleton<_i7.LoginRepository>(() => _i8.LoginRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i4.SharedPreferences>(),
        ));
    gh.factory<_i9.SignupEmailPasswordUseCase>(
        () => _i9.SignupEmailPasswordUseCase(gh<_i5.SignupRepository>()));
    gh.factory<_i10.LoginEmailPasswordUseCase>(
        () => _i10.LoginEmailPasswordUseCase(gh<_i7.LoginRepository>()));
    gh.factory<_i11.LoginGoogleUseCase>(
        () => _i11.LoginGoogleUseCase(gh<_i7.LoginRepository>()));
    gh.factory<_i12.SignUpBloc>(
        () => _i12.SignUpBloc(gh<_i9.SignupEmailPasswordUseCase>()));
    gh.factory<_i13.LoginBloc>(() => _i13.LoginBloc(
          gh<_i10.LoginEmailPasswordUseCase>(),
          gh<_i11.LoginGoogleUseCase>(),
        ));
    return this;
  }
}

class _$InjectionModule extends _i14.InjectionModule {}
