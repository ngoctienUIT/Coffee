// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:coffee/injection.dart' as _i39;
import 'package:coffee/src/data/remote/api_service/api_service.dart' as _i3;
import 'package:coffee/src/data/remote/firebase/firebase_service.dart' as _i4;
import 'package:coffee/src/data/repositories/forgot_password_repository_impl.dart'
    as _i6;
import 'package:coffee/src/data/repositories/input_info_repository_impl.dart'
    as _i9;
import 'package:coffee/src/data/repositories/input_pin_repository_impl.dart'
    as _i12;
import 'package:coffee/src/data/repositories/login_repository_impl.dart'
    as _i27;
import 'package:coffee/src/data/repositories/new_password_repository_impl.dart'
    as _i15;
import 'package:coffee/src/data/repositories/search_repository_impl.dart'
    as _i18;
import 'package:coffee/src/data/repositories/setting_repository_impl.dart'
    as _i31;
import 'package:coffee/src/data/repositories/signup_repository_impl.dart'
    as _i22;
import 'package:coffee/src/domain/repositories/forgot_password_repository.dart'
    as _i5;
import 'package:coffee/src/domain/repositories/input_info_repository.dart'
    as _i8;
import 'package:coffee/src/domain/repositories/input_pin_repository.dart'
    as _i11;
import 'package:coffee/src/domain/repositories/login_repository.dart' as _i26;
import 'package:coffee/src/domain/repositories/new_password_repository.dart'
    as _i14;
import 'package:coffee/src/domain/repositories/search_repository.dart' as _i17;
import 'package:coffee/src/domain/repositories/setting_repository.dart' as _i30;
import 'package:coffee/src/domain/repositories/signup_repository.dart' as _i21;
import 'package:coffee/src/domain/use_cases/forgot_password_use_case/forgot_password.dart'
    as _i7;
import 'package:coffee/src/domain/use_cases/input_info_use_case/input_info.dart'
    as _i10;
import 'package:coffee/src/domain/use_cases/input_pin_use_case/input_pin.dart'
    as _i13;
import 'package:coffee/src/domain/use_cases/login_use_case/login_email_password.dart'
    as _i34;
import 'package:coffee/src/domain/use_cases/login_use_case/login_google.dart'
    as _i35;
import 'package:coffee/src/domain/use_cases/new_password_use_case/new_password.dart'
    as _i16;
import 'package:coffee/src/domain/use_cases/search_use_case/search.dart'
    as _i19;
import 'package:coffee/src/domain/use_cases/setting_use_case/delete_account.dart'
    as _i33;
import 'package:coffee/src/domain/use_cases/signup_use_case/signup_email_password.dart'
    as _i32;
import 'package:coffee/src/presentation/forgot_password/bloc/forgot_password_bloc.dart'
    as _i23;
import 'package:coffee/src/presentation/input_info/bloc/input_info_bloc.dart'
    as _i24;
import 'package:coffee/src/presentation/input_pin/bloc/input_pin_bloc.dart'
    as _i25;
import 'package:coffee/src/presentation/login/bloc/login_bloc.dart' as _i38;
import 'package:coffee/src/presentation/new_password/bloc/new_password_bloc.dart'
    as _i28;
import 'package:coffee/src/presentation/search/bloc/search_bloc.dart' as _i29;
import 'package:coffee/src/presentation/setting/bloc/setting_bloc.dart' as _i36;
import 'package:coffee/src/presentation/signup/bloc/signup_bloc.dart' as _i37;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i20;

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
    gh.lazySingleton<_i3.ApiService>(() => injectionModule.apiService);
    gh.lazySingleton<_i4.FirebaseService>(
        () => injectionModule.firebaseService);
    gh.lazySingleton<_i5.ForgotPasswordRepository>(
        () => _i6.ForgotPasswordRepositoryImpl(gh<_i3.ApiService>()));
    gh.lazySingleton<_i7.ForgotPasswordUseCase>(
        () => _i7.ForgotPasswordUseCase(gh<_i5.ForgotPasswordRepository>()));
    gh.lazySingleton<_i8.InputInfoRepository>(
        () => _i9.InputInfoRepositoryImpl(gh<_i3.ApiService>()));
    gh.lazySingleton<_i10.InputInfoUseCase>(
        () => _i10.InputInfoUseCase(gh<_i8.InputInfoRepository>()));
    gh.lazySingleton<_i11.InputPinRepository>(
        () => _i12.InputPinRepositoryImpl(gh<_i3.ApiService>()));
    gh.lazySingleton<_i13.InputPinUseCase>(
        () => _i13.InputPinUseCase(gh<_i11.InputPinRepository>()));
    gh.lazySingleton<_i14.NewPasswordRepository>(
        () => _i15.NewPasswordRepositoryImpl(gh<_i3.ApiService>()));
    gh.lazySingleton<_i16.NewPasswordUseCase>(
        () => _i16.NewPasswordUseCase(gh<_i14.NewPasswordRepository>()));
    gh.lazySingleton<_i17.SearchRepository>(
        () => _i18.SearchRepositoryImpl(gh<_i3.ApiService>()));
    gh.lazySingleton<_i19.SearchUseCase>(
        () => _i19.SearchUseCase(gh<_i17.SearchRepository>()));
    await gh.lazySingletonAsync<_i20.SharedPreferences>(
      () => injectionModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i21.SignupRepository>(
        () => _i22.SignupRepositoryImpl(gh<_i3.ApiService>()));
    gh.factory<_i23.ForgotPasswordBloc>(
        () => _i23.ForgotPasswordBloc(gh<_i7.ForgotPasswordUseCase>()));
    gh.factory<_i24.InputInfoBloc>(
        () => _i24.InputInfoBloc(gh<_i10.InputInfoUseCase>()));
    gh.factory<_i25.InputPinBloc>(
        () => _i25.InputPinBloc(gh<_i13.InputPinUseCase>()));
    gh.lazySingleton<_i26.LoginRepository>(() => _i27.LoginRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i20.SharedPreferences>(),
        ));
    gh.factory<_i28.NewPasswordBloc>(
        () => _i28.NewPasswordBloc(gh<_i16.NewPasswordUseCase>()));
    gh.factory<_i29.SearchBloc>(
        () => _i29.SearchBloc(gh<_i19.SearchUseCase>()));
    gh.lazySingleton<_i30.SettingRepository>(() => _i31.SettingRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i20.SharedPreferences>(),
        ));
    gh.lazySingleton<_i32.SignupEmailPasswordUseCase>(
        () => _i32.SignupEmailPasswordUseCase(gh<_i21.SignupRepository>()));
    gh.lazySingleton<_i33.DeleteAccountUseCase>(
        () => _i33.DeleteAccountUseCase(gh<_i30.SettingRepository>()));
    gh.lazySingleton<_i34.LoginEmailPasswordUseCase>(
        () => _i34.LoginEmailPasswordUseCase(gh<_i26.LoginRepository>()));
    gh.lazySingleton<_i35.LoginGoogleUseCase>(
        () => _i35.LoginGoogleUseCase(gh<_i26.LoginRepository>()));
    gh.factory<_i36.SettingBloc>(
        () => _i36.SettingBloc(gh<_i33.DeleteAccountUseCase>()));
    gh.factory<_i37.SignUpBloc>(
        () => _i37.SignUpBloc(gh<_i32.SignupEmailPasswordUseCase>()));
    gh.factory<_i38.LoginBloc>(() => _i38.LoginBloc(
          gh<_i34.LoginEmailPasswordUseCase>(),
          gh<_i35.LoginGoogleUseCase>(),
        ));
    return this;
  }
}

class _$InjectionModule extends _i39.InjectionModule {}
