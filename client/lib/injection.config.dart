// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:coffee/injection.dart' as _i58;
import 'package:coffee/src/data/local/dao/user_dao.dart' as _i24;
import 'package:coffee/src/data/local/database/coffee_database.dart' as _i4;
import 'package:coffee/src/data/remote/api_service/api_service.dart' as _i3;
import 'package:coffee/src/data/remote/firebase/firebase_service.dart' as _i5;
import 'package:coffee/src/data/repositories/activity_repository_impl.dart'
    as _i28;
import 'package:coffee/src/data/repositories/change_password_repository_impl.dart'
    as _i31;
import 'package:coffee/src/data/repositories/coupon_repository_impl.dart'
    as _i34;
import 'package:coffee/src/data/repositories/forgot_password_repository_impl.dart'
    as _i7;
import 'package:coffee/src/data/repositories/input_info_repository_impl.dart'
    as _i10;
import 'package:coffee/src/data/repositories/input_pin_repository_impl.dart'
    as _i13;
import 'package:coffee/src/data/repositories/login_repository_impl.dart'
    as _i42;
import 'package:coffee/src/data/repositories/new_password_repository_impl.dart'
    as _i16;
import 'package:coffee/src/data/repositories/search_repository_impl.dart'
    as _i19;
import 'package:coffee/src/data/repositories/setting_repository_impl.dart'
    as _i46;
import 'package:coffee/src/data/repositories/signup_repository_impl.dart'
    as _i23;
import 'package:coffee/src/data/repositories/view_order_repository_impl.dart'
    as _i26;
import 'package:coffee/src/domain/repositories/activity_repository.dart'
    as _i27;
import 'package:coffee/src/domain/repositories/change_password_repository.dart'
    as _i30;
import 'package:coffee/src/domain/repositories/coupon_repository.dart' as _i33;
import 'package:coffee/src/domain/repositories/forgot_password_repository.dart'
    as _i6;
import 'package:coffee/src/domain/repositories/input_info_repository.dart'
    as _i9;
import 'package:coffee/src/domain/repositories/input_pin_repository.dart'
    as _i12;
import 'package:coffee/src/domain/repositories/login_repository.dart' as _i41;
import 'package:coffee/src/domain/repositories/new_password_repository.dart'
    as _i15;
import 'package:coffee/src/domain/repositories/search_repository.dart' as _i18;
import 'package:coffee/src/domain/repositories/setting_repository.dart' as _i45;
import 'package:coffee/src/domain/repositories/signup_repository.dart' as _i22;
import 'package:coffee/src/domain/repositories/view_order_repository.dart'
    as _i25;
import 'package:coffee/src/domain/use_cases/activity_use_case/get_activity.dart'
    as _i36;
import 'package:coffee/src/domain/use_cases/change_password_use_case/change_password.dart'
    as _i32;
import 'package:coffee/src/domain/use_cases/coupon_use_case/get_coupon.dart'
    as _i37;
import 'package:coffee/src/domain/use_cases/forgot_password_use_case/forgot_password.dart'
    as _i8;
import 'package:coffee/src/domain/use_cases/input_info_use_case/input_info.dart'
    as _i11;
import 'package:coffee/src/domain/use_cases/input_pin_use_case/input_pin.dart'
    as _i14;
import 'package:coffee/src/domain/use_cases/login_use_case/login_email_password.dart'
    as _i53;
import 'package:coffee/src/domain/use_cases/login_use_case/login_google.dart'
    as _i54;
import 'package:coffee/src/domain/use_cases/new_password_use_case/new_password.dart'
    as _i17;
import 'package:coffee/src/domain/use_cases/search_use_case/search.dart'
    as _i20;
import 'package:coffee/src/domain/use_cases/setting_use_case/delete_account.dart'
    as _i52;
import 'package:coffee/src/domain/use_cases/signup_use_case/signup_email_password.dart'
    as _i47;
import 'package:coffee/src/domain/use_cases/view_order_use_case/cancel_order.dart'
    as _i29;
import 'package:coffee/src/domain/use_cases/view_order_use_case/get_order.dart'
    as _i38;
import 'package:coffee/src/presentation/activity/bloc/activity_bloc.dart'
    as _i49;
import 'package:coffee/src/presentation/change_password/bloc/change_password_bloc.dart'
    as _i50;
import 'package:coffee/src/presentation/coupon/bloc/coupon_bloc.dart' as _i51;
import 'package:coffee/src/presentation/forgot_password/bloc/forgot_password_bloc.dart'
    as _i35;
import 'package:coffee/src/presentation/input_info/bloc/input_info_bloc.dart'
    as _i39;
import 'package:coffee/src/presentation/input_pin/bloc/input_pin_bloc.dart'
    as _i40;
import 'package:coffee/src/presentation/login/bloc/login_bloc.dart' as _i57;
import 'package:coffee/src/presentation/new_password/bloc/new_password_bloc.dart'
    as _i43;
import 'package:coffee/src/presentation/search/bloc/search_bloc.dart' as _i44;
import 'package:coffee/src/presentation/setting/bloc/setting_bloc.dart' as _i55;
import 'package:coffee/src/presentation/signup/bloc/signup_bloc.dart' as _i56;
import 'package:coffee/src/presentation/view_order/bloc/view_order_bloc.dart'
    as _i48;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i21;

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
    await gh.lazySingletonAsync<_i4.CoffeeDatabase>(
      () => injectionModule.database,
      preResolve: true,
    );
    gh.lazySingleton<_i5.FirebaseService>(
        () => injectionModule.firebaseService);
    gh.lazySingleton<_i6.ForgotPasswordRepository>(
        () => _i7.ForgotPasswordRepositoryImpl(gh<_i3.ApiService>()));
    gh.lazySingleton<_i8.ForgotPasswordUseCase>(
        () => _i8.ForgotPasswordUseCase(gh<_i6.ForgotPasswordRepository>()));
    gh.lazySingleton<_i9.InputInfoRepository>(
        () => _i10.InputInfoRepositoryImpl(gh<_i3.ApiService>()));
    gh.lazySingleton<_i11.InputInfoUseCase>(
        () => _i11.InputInfoUseCase(gh<_i9.InputInfoRepository>()));
    gh.lazySingleton<_i12.InputPinRepository>(
        () => _i13.InputPinRepositoryImpl(gh<_i3.ApiService>()));
    gh.lazySingleton<_i14.InputPinUseCase>(
        () => _i14.InputPinUseCase(gh<_i12.InputPinRepository>()));
    gh.lazySingleton<_i15.NewPasswordRepository>(
        () => _i16.NewPasswordRepositoryImpl(gh<_i3.ApiService>()));
    gh.lazySingleton<_i17.NewPasswordUseCase>(
        () => _i17.NewPasswordUseCase(gh<_i15.NewPasswordRepository>()));
    gh.lazySingleton<_i18.SearchRepository>(
        () => _i19.SearchRepositoryImpl(gh<_i3.ApiService>()));
    gh.lazySingleton<_i20.SearchUseCase>(
        () => _i20.SearchUseCase(gh<_i18.SearchRepository>()));
    await gh.lazySingletonAsync<_i21.SharedPreferences>(
      () => injectionModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i22.SignupRepository>(
        () => _i23.SignupRepositoryImpl(gh<_i3.ApiService>()));
    gh.lazySingleton<_i24.UserDao>(() => injectionModule.userDao);
    gh.lazySingleton<_i25.ViewOrderRepository>(
        () => _i26.ViewOrderRepositoryImpl(
              gh<_i3.ApiService>(),
              gh<_i21.SharedPreferences>(),
            ));
    gh.lazySingleton<_i27.ActivityRepository>(() => _i28.ActivityRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i21.SharedPreferences>(),
          gh<_i24.UserDao>(),
        ));
    gh.lazySingleton<_i29.CancelOrderUseCase>(
        () => _i29.CancelOrderUseCase(gh<_i25.ViewOrderRepository>()));
    gh.lazySingleton<_i30.ChangePasswordRepository>(
        () => _i31.ChangePasswordRepositoryImpl(
              gh<_i3.ApiService>(),
              gh<_i21.SharedPreferences>(),
              gh<_i24.UserDao>(),
            ));
    gh.lazySingleton<_i32.ChangePasswordUseCase>(
        () => _i32.ChangePasswordUseCase(gh<_i30.ChangePasswordRepository>()));
    gh.lazySingleton<_i33.CouponRepository>(() => _i34.CouponRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i21.SharedPreferences>(),
          gh<_i24.UserDao>(),
        ));
    gh.factory<_i35.ForgotPasswordBloc>(
        () => _i35.ForgotPasswordBloc(gh<_i8.ForgotPasswordUseCase>()));
    gh.lazySingleton<_i36.GetActivityUseCase>(
        () => _i36.GetActivityUseCase(gh<_i27.ActivityRepository>()));
    gh.lazySingleton<_i37.GetCouponUseCase>(
        () => _i37.GetCouponUseCase(gh<_i33.CouponRepository>()));
    gh.lazySingleton<_i38.GetOrderUserCase>(
        () => _i38.GetOrderUserCase(gh<_i25.ViewOrderRepository>()));
    gh.factory<_i39.InputInfoBloc>(
        () => _i39.InputInfoBloc(gh<_i11.InputInfoUseCase>()));
    gh.factory<_i40.InputPinBloc>(
        () => _i40.InputPinBloc(gh<_i14.InputPinUseCase>()));
    gh.lazySingleton<_i41.LoginRepository>(() => _i42.LoginRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i21.SharedPreferences>(),
        ));
    gh.factory<_i43.NewPasswordBloc>(
        () => _i43.NewPasswordBloc(gh<_i17.NewPasswordUseCase>()));
    gh.factory<_i44.SearchBloc>(
        () => _i44.SearchBloc(gh<_i20.SearchUseCase>()));
    gh.lazySingleton<_i45.SettingRepository>(() => _i46.SettingRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i21.SharedPreferences>(),
        ));
    gh.lazySingleton<_i47.SignupEmailPasswordUseCase>(
        () => _i47.SignupEmailPasswordUseCase(gh<_i22.SignupRepository>()));
    gh.factory<_i48.ViewOrderBloc>(() => _i48.ViewOrderBloc(
          gh<_i38.GetOrderUserCase>(),
          gh<_i29.CancelOrderUseCase>(),
        ));
    gh.factory<_i49.ActivityBloc>(
        () => _i49.ActivityBloc(gh<_i36.GetActivityUseCase>()));
    gh.factory<_i50.ChangePasswordBloc>(
        () => _i50.ChangePasswordBloc(gh<_i32.ChangePasswordUseCase>()));
    gh.factory<_i51.CouponBloc>(
        () => _i51.CouponBloc(gh<_i37.GetCouponUseCase>()));
    gh.lazySingleton<_i52.DeleteAccountUseCase>(
        () => _i52.DeleteAccountUseCase(gh<_i45.SettingRepository>()));
    gh.lazySingleton<_i53.LoginEmailPasswordUseCase>(
        () => _i53.LoginEmailPasswordUseCase(gh<_i41.LoginRepository>()));
    gh.lazySingleton<_i54.LoginGoogleUseCase>(
        () => _i54.LoginGoogleUseCase(gh<_i41.LoginRepository>()));
    gh.factory<_i55.SettingBloc>(
        () => _i55.SettingBloc(gh<_i52.DeleteAccountUseCase>()));
    gh.factory<_i56.SignUpBloc>(
        () => _i56.SignUpBloc(gh<_i47.SignupEmailPasswordUseCase>()));
    gh.factory<_i57.LoginBloc>(() => _i57.LoginBloc(
          gh<_i53.LoginEmailPasswordUseCase>(),
          gh<_i54.LoginGoogleUseCase>(),
        ));
    return this;
  }
}

class _$InjectionModule extends _i58.InjectionModule {}
