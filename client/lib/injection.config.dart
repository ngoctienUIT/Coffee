// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:coffee/injection.dart' as _i102;
import 'package:coffee/src/core/services/bloc/service_bloc.dart' as _i72;
import 'package:coffee/src/data/local/dao/store_dao.dart' as _i30;
import 'package:coffee/src/data/local/dao/user_dao.dart' as _i33;
import 'package:coffee/src/data/local/database/coffee_database.dart' as _i4;
import 'package:coffee/src/data/remote/api_service/api_service.dart' as _i3;
import 'package:coffee/src/data/remote/firebase/firebase_service.dart' as _i8;
import 'package:coffee/src/data/repositories/activity_repository_impl.dart'
    as _i37;
import 'package:coffee/src/data/repositories/cart_repository_impl.dart' as _i40;
import 'package:coffee/src/data/repositories/change_password_repository_impl.dart'
    as _i43;
import 'package:coffee/src/data/repositories/coupon_repository_impl.dart'
    as _i6;
import 'package:coffee/src/data/repositories/forgot_password_repository_impl.dart'
    as _i10;
import 'package:coffee/src/data/repositories/home_repository_impl.dart' as _i57;
import 'package:coffee/src/data/repositories/input_info_repository_impl.dart'
    as _i14;
import 'package:coffee/src/data/repositories/input_pin_repository_impl.dart'
    as _i17;
import 'package:coffee/src/data/repositories/login_repository_impl.dart'
    as _i61;
import 'package:coffee/src/data/repositories/new_password_repository_impl.dart'
    as _i20;
import 'package:coffee/src/data/repositories/order_repository_impl.dart'
    as _i23;
import 'package:coffee/src/data/repositories/product_repository_impl.dart'
    as _i66;
import 'package:coffee/src/data/repositories/profile_repository_impl.dart'
    as _i68;
import 'package:coffee/src/data/repositories/search_repository_impl.dart'
    as _i25;
import 'package:coffee/src/data/repositories/setting_repository_impl.dart'
    as _i74;
import 'package:coffee/src/data/repositories/signup_repository_impl.dart'
    as _i29;
import 'package:coffee/src/data/repositories/store_repository_impl.dart'
    as _i32;
import 'package:coffee/src/data/repositories/view_order_repository_impl.dart'
    as _i35;
import 'package:coffee/src/domain/repositories/activity_repository.dart'
    as _i36;
import 'package:coffee/src/domain/repositories/cart_repository.dart' as _i39;
import 'package:coffee/src/domain/repositories/change_password_repository.dart'
    as _i42;
import 'package:coffee/src/domain/repositories/coupon_repository.dart' as _i5;
import 'package:coffee/src/domain/repositories/forgot_password_repository.dart'
    as _i9;
import 'package:coffee/src/domain/repositories/home_repository.dart' as _i56;
import 'package:coffee/src/domain/repositories/input_info_repository.dart'
    as _i13;
import 'package:coffee/src/domain/repositories/input_pin_repository.dart'
    as _i16;
import 'package:coffee/src/domain/repositories/login_repository.dart' as _i60;
import 'package:coffee/src/domain/repositories/new_password_repository.dart'
    as _i19;
import 'package:coffee/src/domain/repositories/order_repository.dart' as _i22;
import 'package:coffee/src/domain/repositories/product_repository.dart' as _i65;
import 'package:coffee/src/domain/repositories/profile_repository.dart' as _i67;
import 'package:coffee/src/domain/repositories/search_repository.dart' as _i24;
import 'package:coffee/src/domain/repositories/setting_repository.dart' as _i73;
import 'package:coffee/src/domain/repositories/signup_repository.dart' as _i28;
import 'package:coffee/src/domain/repositories/store_repository.dart' as _i31;
import 'package:coffee/src/domain/repositories/view_order_repository.dart'
    as _i34;
import 'package:coffee/src/domain/use_cases/activity_use_case/get_activity.dart'
    as _i50;
import 'package:coffee/src/domain/use_cases/cart_use_case/add_note.dart'
    as _i82;
import 'package:coffee/src/domain/use_cases/cart_use_case/attach_coupon_to_order.dart'
    as _i83;
import 'package:coffee/src/domain/use_cases/cart_use_case/change_method.dart'
    as _i41;
import 'package:coffee/src/domain/use_cases/cart_use_case/delete_coupon_order.dart'
    as _i46;
import 'package:coffee/src/domain/use_cases/cart_use_case/delete_order_spending.dart'
    as _i47;
import 'package:coffee/src/domain/use_cases/cart_use_case/delete_product.dart'
    as _i48;
import 'package:coffee/src/domain/use_cases/cart_use_case/place_oder.dart'
    as _i64;
import 'package:coffee/src/domain/use_cases/change_password_use_case/change_password.dart'
    as _i44;
import 'package:coffee/src/domain/use_cases/coupon_use_case/get_coupon.dart'
    as _i12;
import 'package:coffee/src/domain/use_cases/forgot_password_use_case/forgot_password.dart'
    as _i11;
import 'package:coffee/src/domain/use_cases/home_use_case/get_coupon.dart'
    as _i90;
import 'package:coffee/src/domain/use_cases/home_use_case/get_order_spending.dart'
    as _i91;
import 'package:coffee/src/domain/use_cases/home_use_case/get_recommend.dart'
    as _i92;
import 'package:coffee/src/domain/use_cases/input_info_use_case/input_info.dart'
    as _i15;
import 'package:coffee/src/domain/use_cases/input_pin_use_case/input_pin.dart'
    as _i18;
import 'package:coffee/src/domain/use_cases/login_use_case/login_email_password.dart'
    as _i95;
import 'package:coffee/src/domain/use_cases/login_use_case/login_google.dart'
    as _i96;
import 'package:coffee/src/domain/use_cases/new_password_use_case/new_password.dart'
    as _i21;
import 'package:coffee/src/domain/use_cases/order_use_case/get_list_product.dart'
    as _i53;
import 'package:coffee/src/domain/use_cases/order_use_case/get_list_product_catalogues.dart'
    as _i52;
import 'package:coffee/src/domain/use_cases/product_use_case/create_new_order.dart'
    as _i86;
import 'package:coffee/src/domain/use_cases/product_use_case/delete_product_in_order.dart'
    as _i89;
import 'package:coffee/src/domain/use_cases/product_use_case/update_pending_order.dart'
    as _i78;
import 'package:coffee/src/domain/use_cases/product_use_case/update_product_in_order.dart'
    as _i79;
import 'package:coffee/src/domain/use_cases/profile_use_case/delete_avatar.dart'
    as _i88;
import 'package:coffee/src/domain/use_cases/profile_use_case/link_account_with_google.dart'
    as _i94;
import 'package:coffee/src/domain/use_cases/profile_use_case/save_profile.dart'
    as _i69;
import 'package:coffee/src/domain/use_cases/profile_use_case/unlink_account_with_google.dart'
    as _i77;
import 'package:coffee/src/domain/use_cases/search_use_case/search.dart'
    as _i26;
import 'package:coffee/src/domain/use_cases/setting_use_case/delete_account.dart'
    as _i87;
import 'package:coffee/src/domain/use_cases/signup_use_case/signup_email_password.dart'
    as _i75;
import 'package:coffee/src/domain/use_cases/store_use_case/get_data_store.dart'
    as _i51;
import 'package:coffee/src/domain/use_cases/store_use_case/get_store.dart'
    as _i55;
import 'package:coffee/src/domain/use_cases/store_use_case/search_store.dart'
    as _i71;
import 'package:coffee/src/domain/use_cases/view_order_use_case/cancel_order.dart'
    as _i38;
import 'package:coffee/src/domain/use_cases/view_order_use_case/get_order.dart'
    as _i54;
import 'package:coffee/src/presentation/activity/bloc/activity_bloc.dart'
    as _i81;
import 'package:coffee/src/presentation/cart/bloc/cart_bloc.dart' as _i84;
import 'package:coffee/src/presentation/change_password/bloc/change_password_bloc.dart'
    as _i85;
import 'package:coffee/src/presentation/coupon/bloc/coupon_bloc.dart' as _i45;
import 'package:coffee/src/presentation/forgot_password/bloc/forgot_password_bloc.dart'
    as _i49;
import 'package:coffee/src/presentation/home/bloc/home_bloc.dart' as _i93;
import 'package:coffee/src/presentation/input_info/bloc/input_info_bloc.dart'
    as _i58;
import 'package:coffee/src/presentation/input_pin/bloc/input_pin_bloc.dart'
    as _i59;
import 'package:coffee/src/presentation/login/bloc/login_bloc.dart' as _i101;
import 'package:coffee/src/presentation/new_password/bloc/new_password_bloc.dart'
    as _i62;
import 'package:coffee/src/presentation/order/bloc/order_bloc.dart' as _i63;
import 'package:coffee/src/presentation/product/bloc/product_bloc.dart' as _i97;
import 'package:coffee/src/presentation/profile/bloc/profile_bloc.dart' as _i98;
import 'package:coffee/src/presentation/search/bloc/search_bloc.dart' as _i70;
import 'package:coffee/src/presentation/setting/bloc/setting_bloc.dart' as _i99;
import 'package:coffee/src/presentation/signup/bloc/signup_bloc.dart' as _i100;
import 'package:coffee/src/presentation/store/bloc/store_bloc.dart' as _i76;
import 'package:coffee/src/presentation/view_order/bloc/view_order_bloc.dart'
    as _i80;
import 'package:dio/dio.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i27;

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
    gh.lazySingleton<_i5.CouponRepository>(
        () => _i6.CouponRepositoryImpl(gh<_i3.ApiService>()));
    gh.lazySingleton<_i7.Dio>(() => injectionModule.dio);
    gh.lazySingleton<_i8.FirebaseService>(
        () => injectionModule.firebaseService);
    gh.lazySingleton<_i9.ForgotPasswordRepository>(
        () => _i10.ForgotPasswordRepositoryImpl(gh<_i3.ApiService>()));
    gh.lazySingleton<_i11.ForgotPasswordUseCase>(
        () => _i11.ForgotPasswordUseCase(gh<_i9.ForgotPasswordRepository>()));
    gh.lazySingleton<_i12.GetCouponUseCase>(
        () => _i12.GetCouponUseCase(gh<_i5.CouponRepository>()));
    gh.lazySingleton<_i13.InputInfoRepository>(
        () => _i14.InputInfoRepositoryImpl(gh<_i3.ApiService>()));
    gh.lazySingleton<_i15.InputInfoUseCase>(
        () => _i15.InputInfoUseCase(gh<_i13.InputInfoRepository>()));
    gh.lazySingleton<_i16.InputPinRepository>(
        () => _i17.InputPinRepositoryImpl(gh<_i3.ApiService>()));
    gh.lazySingleton<_i18.InputPinUseCase>(
        () => _i18.InputPinUseCase(gh<_i16.InputPinRepository>()));
    gh.lazySingleton<_i19.NewPasswordRepository>(
        () => _i20.NewPasswordRepositoryImpl(gh<_i3.ApiService>()));
    gh.lazySingleton<_i21.NewPasswordUseCase>(
        () => _i21.NewPasswordUseCase(gh<_i19.NewPasswordRepository>()));
    gh.lazySingleton<_i22.OrderRepository>(
        () => _i23.OrderRepositoryImpl(gh<_i3.ApiService>()));
    gh.lazySingleton<_i24.SearchRepository>(
        () => _i25.SearchRepositoryImpl(gh<_i3.ApiService>()));
    gh.lazySingleton<_i26.SearchUseCase>(
        () => _i26.SearchUseCase(gh<_i24.SearchRepository>()));
    await gh.lazySingletonAsync<_i27.SharedPreferences>(
      () => injectionModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i28.SignupRepository>(
        () => _i29.SignupRepositoryImpl(gh<_i3.ApiService>()));
    gh.lazySingleton<_i30.StoreDao>(() => injectionModule.storeDao);
    gh.lazySingleton<_i31.StoreRepository>(() => _i32.StoreRepositoryImpl(
          gh<_i30.StoreDao>(),
          gh<_i3.ApiService>(),
        ));
    gh.lazySingleton<_i33.UserDao>(() => injectionModule.userDao);
    gh.lazySingleton<_i34.ViewOrderRepository>(
        () => _i35.ViewOrderRepositoryImpl(
              gh<_i3.ApiService>(),
              gh<_i27.SharedPreferences>(),
            ));
    gh.lazySingleton<_i36.ActivityRepository>(() => _i37.ActivityRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i27.SharedPreferences>(),
        ));
    gh.lazySingleton<_i38.CancelOrderUseCase>(
        () => _i38.CancelOrderUseCase(gh<_i34.ViewOrderRepository>()));
    gh.lazySingleton<_i39.CartRepository>(() => _i40.CartRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i27.SharedPreferences>(),
        ));
    gh.lazySingleton<_i41.ChangeMethodUseCase>(
        () => _i41.ChangeMethodUseCase(gh<_i39.CartRepository>()));
    gh.lazySingleton<_i42.ChangePasswordRepository>(
        () => _i43.ChangePasswordRepositoryImpl(
              gh<_i3.ApiService>(),
              gh<_i27.SharedPreferences>(),
              gh<_i33.UserDao>(),
            ));
    gh.lazySingleton<_i44.ChangePasswordUseCase>(
        () => _i44.ChangePasswordUseCase(gh<_i42.ChangePasswordRepository>()));
    gh.factory<_i45.CouponBloc>(
        () => _i45.CouponBloc(gh<_i12.GetCouponUseCase>()));
    gh.lazySingleton<_i46.DeleteCouponOrderUseCase>(
        () => _i46.DeleteCouponOrderUseCase(gh<_i39.CartRepository>()));
    gh.lazySingleton<_i47.DeleteOrderSpendingUseCase>(
        () => _i47.DeleteOrderSpendingUseCase(gh<_i39.CartRepository>()));
    gh.lazySingleton<_i48.DeleteProductUseCase>(
        () => _i48.DeleteProductUseCase(gh<_i39.CartRepository>()));
    gh.factory<_i49.ForgotPasswordBloc>(
        () => _i49.ForgotPasswordBloc(gh<_i11.ForgotPasswordUseCase>()));
    gh.lazySingleton<_i50.GetActivityUseCase>(
        () => _i50.GetActivityUseCase(gh<_i36.ActivityRepository>()));
    gh.lazySingleton<_i51.GetDataStoreUseCase>(
        () => _i51.GetDataStoreUseCase(gh<_i31.StoreRepository>()));
    gh.lazySingleton<_i52.GetListProductCatalogues>(
        () => _i52.GetListProductCatalogues(gh<_i22.OrderRepository>()));
    gh.lazySingleton<_i53.GetListProductUseCase>(
        () => _i53.GetListProductUseCase(gh<_i22.OrderRepository>()));
    gh.lazySingleton<_i54.GetOrderUserCase>(
        () => _i54.GetOrderUserCase(gh<_i34.ViewOrderRepository>()));
    gh.lazySingleton<_i55.GetStoreUseCase>(
        () => _i55.GetStoreUseCase(gh<_i31.StoreRepository>()));
    gh.lazySingleton<_i56.HomeRepository>(() => _i57.HomeRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i27.SharedPreferences>(),
          gh<_i30.StoreDao>(),
        ));
    gh.factory<_i58.InputInfoBloc>(
        () => _i58.InputInfoBloc(gh<_i15.InputInfoUseCase>()));
    gh.factory<_i59.InputPinBloc>(
        () => _i59.InputPinBloc(gh<_i18.InputPinUseCase>()));
    gh.lazySingleton<_i60.LoginRepository>(() => _i61.LoginRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i27.SharedPreferences>(),
        ));
    gh.factory<_i62.NewPasswordBloc>(
        () => _i62.NewPasswordBloc(gh<_i21.NewPasswordUseCase>()));
    gh.factory<_i63.OrderBloc>(() => _i63.OrderBloc(
          gh<_i53.GetListProductUseCase>(),
          gh<_i52.GetListProductCatalogues>(),
        ));
    gh.lazySingleton<_i64.PlaceOrderUseCase>(
        () => _i64.PlaceOrderUseCase(gh<_i39.CartRepository>()));
    gh.lazySingleton<_i65.ProductRepository>(() => _i66.ProductRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i27.SharedPreferences>(),
        ));
    gh.lazySingleton<_i67.ProfileRepository>(() => _i68.ProfileRepositoryImpl(
          gh<_i27.SharedPreferences>(),
          gh<_i3.ApiService>(),
        ));
    gh.lazySingleton<_i69.SaveProfileUseCase>(
        () => _i69.SaveProfileUseCase(gh<_i67.ProfileRepository>()));
    gh.factory<_i70.SearchBloc>(
        () => _i70.SearchBloc(gh<_i26.SearchUseCase>()));
    gh.lazySingleton<_i71.SearchStoreUseCase>(
        () => _i71.SearchStoreUseCase(gh<_i31.StoreRepository>()));
    gh.factory<_i72.ServiceBloc>(() => _i72.ServiceBloc(
          gh<_i27.SharedPreferences>(),
          gh<_i3.ApiService>(),
        ));
    gh.lazySingleton<_i73.SettingRepository>(() => _i74.SettingRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i27.SharedPreferences>(),
        ));
    gh.lazySingleton<_i75.SignupEmailPasswordUseCase>(
        () => _i75.SignupEmailPasswordUseCase(gh<_i28.SignupRepository>()));
    gh.factory<_i76.StoreBloc>(() => _i76.StoreBloc(
          gh<_i27.SharedPreferences>(),
          gh<_i51.GetDataStoreUseCase>(),
          gh<_i55.GetStoreUseCase>(),
          gh<_i71.SearchStoreUseCase>(),
        ));
    gh.lazySingleton<_i77.UnlinkAccountWithGoogleUseCase>(() =>
        _i77.UnlinkAccountWithGoogleUseCase(gh<_i67.ProfileRepository>()));
    gh.lazySingleton<_i78.UpdatePendingOrderUseCase>(
        () => _i78.UpdatePendingOrderUseCase(gh<_i65.ProductRepository>()));
    gh.lazySingleton<_i79.UpdateProductInOrderUseCase>(
        () => _i79.UpdateProductInOrderUseCase(gh<_i65.ProductRepository>()));
    gh.factory<_i80.ViewOrderBloc>(() => _i80.ViewOrderBloc(
          gh<_i54.GetOrderUserCase>(),
          gh<_i38.CancelOrderUseCase>(),
        ));
    gh.factory<_i81.ActivityBloc>(
        () => _i81.ActivityBloc(gh<_i50.GetActivityUseCase>()));
    gh.lazySingleton<_i82.AddNoteUseCase>(
        () => _i82.AddNoteUseCase(gh<_i39.CartRepository>()));
    gh.lazySingleton<_i83.AttachCouponToOrderUseCase>(
        () => _i83.AttachCouponToOrderUseCase(gh<_i39.CartRepository>()));
    gh.factory<_i84.CartBloc>(() => _i84.CartBloc(
          gh<_i48.DeleteProductUseCase>(),
          gh<_i64.PlaceOrderUseCase>(),
          gh<_i47.DeleteOrderSpendingUseCase>(),
          gh<_i46.DeleteCouponOrderUseCase>(),
          gh<_i41.ChangeMethodUseCase>(),
          gh<_i83.AttachCouponToOrderUseCase>(),
          gh<_i82.AddNoteUseCase>(),
        ));
    gh.factory<_i85.ChangePasswordBloc>(
        () => _i85.ChangePasswordBloc(gh<_i44.ChangePasswordUseCase>()));
    gh.lazySingleton<_i86.CreateNewOrderUseCase>(
        () => _i86.CreateNewOrderUseCase(gh<_i65.ProductRepository>()));
    gh.lazySingleton<_i87.DeleteAccountUseCase>(
        () => _i87.DeleteAccountUseCase(gh<_i73.SettingRepository>()));
    gh.lazySingleton<_i88.DeleteAvatarUseCase>(
        () => _i88.DeleteAvatarUseCase(gh<_i67.ProfileRepository>()));
    gh.factory<_i89.DeleteProductInOrderUseCase>(
        () => _i89.DeleteProductInOrderUseCase(gh<_i65.ProductRepository>()));
    gh.lazySingleton<_i90.GetCouponUseCase>(
        () => _i90.GetCouponUseCase(gh<_i56.HomeRepository>()));
    gh.lazySingleton<_i91.GetOrderSpendingUseCase>(
        () => _i91.GetOrderSpendingUseCase(gh<_i56.HomeRepository>()));
    gh.lazySingleton<_i92.GetRecommendUseCase>(
        () => _i92.GetRecommendUseCase(gh<_i56.HomeRepository>()));
    gh.factory<_i93.HomeBloc>(() => _i93.HomeBloc(
          gh<_i92.GetRecommendUseCase>(),
          gh<_i91.GetOrderSpendingUseCase>(),
          gh<_i12.GetCouponUseCase>(),
        ));
    gh.lazySingleton<_i94.LinkAccountWithGoogleUseCase>(
        () => _i94.LinkAccountWithGoogleUseCase(gh<_i67.ProfileRepository>()));
    gh.lazySingleton<_i95.LoginEmailPasswordUseCase>(
        () => _i95.LoginEmailPasswordUseCase(gh<_i60.LoginRepository>()));
    gh.lazySingleton<_i96.LoginGoogleUseCase>(
        () => _i96.LoginGoogleUseCase(gh<_i60.LoginRepository>()));
    gh.factory<_i97.ProductBloc>(() => _i97.ProductBloc(
          gh<_i78.UpdatePendingOrderUseCase>(),
          gh<_i79.UpdateProductInOrderUseCase>(),
          gh<_i89.DeleteProductInOrderUseCase>(),
          gh<_i86.CreateNewOrderUseCase>(),
        ));
    gh.factory<_i98.ProfileBloc>(() => _i98.ProfileBloc(
          gh<_i69.SaveProfileUseCase>(),
          gh<_i77.UnlinkAccountWithGoogleUseCase>(),
          gh<_i94.LinkAccountWithGoogleUseCase>(),
          gh<_i88.DeleteAvatarUseCase>(),
        ));
    gh.factory<_i99.SettingBloc>(
        () => _i99.SettingBloc(gh<_i87.DeleteAccountUseCase>()));
    gh.factory<_i100.SignUpBloc>(
        () => _i100.SignUpBloc(gh<_i75.SignupEmailPasswordUseCase>()));
    gh.factory<_i101.LoginBloc>(() => _i101.LoginBloc(
          gh<_i95.LoginEmailPasswordUseCase>(),
          gh<_i96.LoginGoogleUseCase>(),
        ));
    return this;
  }
}

class _$InjectionModule extends _i102.InjectionModule {}
