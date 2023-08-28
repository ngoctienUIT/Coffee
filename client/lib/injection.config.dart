// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:coffee/injection.dart' as _i96;
import 'package:coffee/src/core/services/bloc/service_bloc.dart' as _i59;
import 'package:coffee/src/data/local/dao/store_dao.dart' as _i21;
import 'package:coffee/src/data/local/dao/user_dao.dart' as _i24;
import 'package:coffee/src/data/local/database/coffee_database.dart' as _i4;
import 'package:coffee/src/data/remote/api_service/api_service.dart' as _i3;
import 'package:coffee/src/data/remote/firebase/firebase_service.dart' as _i8;
import 'package:coffee/src/data/repositories/activity_repository_impl.dart'
    as _i28;
import 'package:coffee/src/data/repositories/cart_repository_impl.dart' as _i31;
import 'package:coffee/src/data/repositories/coupon_repository_impl.dart'
    as _i6;
import 'package:coffee/src/data/repositories/home_repository_impl.dart' as _i44;
import 'package:coffee/src/data/repositories/input_info_repository_impl.dart'
    as _i11;
import 'package:coffee/src/data/repositories/login_repository_impl.dart'
    as _i47;
import 'package:coffee/src/data/repositories/order_repository_impl.dart'
    as _i14;
import 'package:coffee/src/data/repositories/password_repository_impl.dart'
    as _i50;
import 'package:coffee/src/data/repositories/product_repository_impl.dart'
    as _i53;
import 'package:coffee/src/data/repositories/profile_repository_impl.dart'
    as _i55;
import 'package:coffee/src/data/repositories/search_repository_impl.dart'
    as _i16;
import 'package:coffee/src/data/repositories/setting_repository_impl.dart'
    as _i61;
import 'package:coffee/src/data/repositories/signup_repository_impl.dart'
    as _i20;
import 'package:coffee/src/data/repositories/store_repository_impl.dart'
    as _i23;
import 'package:coffee/src/data/repositories/view_order_repository_impl.dart'
    as _i26;
import 'package:coffee/src/domain/repositories/activity_repository.dart'
    as _i27;
import 'package:coffee/src/domain/repositories/cart_repository.dart' as _i30;
import 'package:coffee/src/domain/repositories/coupon_repository.dart' as _i5;
import 'package:coffee/src/domain/repositories/home_repository.dart' as _i43;
import 'package:coffee/src/domain/repositories/input_info_repository.dart'
    as _i10;
import 'package:coffee/src/domain/repositories/login_repository.dart' as _i46;
import 'package:coffee/src/domain/repositories/order_repository.dart' as _i13;
import 'package:coffee/src/domain/repositories/password_repository.dart'
    as _i49;
import 'package:coffee/src/domain/repositories/product_repository.dart' as _i52;
import 'package:coffee/src/domain/repositories/profile_repository.dart' as _i54;
import 'package:coffee/src/domain/repositories/search_repository.dart' as _i15;
import 'package:coffee/src/domain/repositories/setting_repository.dart' as _i60;
import 'package:coffee/src/domain/repositories/signup_repository.dart' as _i19;
import 'package:coffee/src/domain/repositories/store_repository.dart' as _i22;
import 'package:coffee/src/domain/repositories/view_order_repository.dart'
    as _i25;
import 'package:coffee/src/domain/use_cases/activity_use_case/get_activity.dart'
    as _i37;
import 'package:coffee/src/domain/use_cases/cart_use_case/add_note.dart'
    as _i69;
import 'package:coffee/src/domain/use_cases/cart_use_case/attach_coupon_to_order.dart'
    as _i70;
import 'package:coffee/src/domain/use_cases/cart_use_case/change_method.dart'
    as _i32;
import 'package:coffee/src/domain/use_cases/cart_use_case/delete_coupon_order.dart'
    as _i34;
import 'package:coffee/src/domain/use_cases/cart_use_case/delete_order_spending.dart'
    as _i35;
import 'package:coffee/src/domain/use_cases/cart_use_case/delete_product.dart'
    as _i36;
import 'package:coffee/src/domain/use_cases/cart_use_case/place_oder.dart'
    as _i51;
import 'package:coffee/src/domain/use_cases/coupon_use_case/get_coupon.dart'
    as _i9;
import 'package:coffee/src/domain/use_cases/home_use_case/get_coupon.dart'
    as _i79;
import 'package:coffee/src/domain/use_cases/home_use_case/get_order_spending.dart'
    as _i80;
import 'package:coffee/src/domain/use_cases/home_use_case/get_recommend.dart'
    as _i81;
import 'package:coffee/src/domain/use_cases/input_info_use_case/input_info.dart'
    as _i12;
import 'package:coffee/src/domain/use_cases/login_use_case/login_email_password.dart'
    as _i85;
import 'package:coffee/src/domain/use_cases/login_use_case/login_google.dart'
    as _i86;
import 'package:coffee/src/domain/use_cases/order_use_case/get_list_product.dart'
    as _i40;
import 'package:coffee/src/domain/use_cases/order_use_case/get_list_product_catalogues.dart'
    as _i39;
import 'package:coffee/src/domain/use_cases/password_use_case/change_password.dart'
    as _i72;
import 'package:coffee/src/domain/use_cases/password_use_case/create_new_password.dart'
    as _i74;
import 'package:coffee/src/domain/use_cases/password_use_case/forgot_password.dart'
    as _i78;
import 'package:coffee/src/domain/use_cases/password_use_case/input_pin.dart'
    as _i83;
import 'package:coffee/src/domain/use_cases/product_use_case/create_new_order.dart'
    as _i73;
import 'package:coffee/src/domain/use_cases/product_use_case/delete_product_in_order.dart'
    as _i77;
import 'package:coffee/src/domain/use_cases/product_use_case/update_pending_order.dart'
    as _i65;
import 'package:coffee/src/domain/use_cases/product_use_case/update_product_in_order.dart'
    as _i66;
import 'package:coffee/src/domain/use_cases/profile_use_case/delete_avatar.dart'
    as _i76;
import 'package:coffee/src/domain/use_cases/profile_use_case/link_account_with_google.dart'
    as _i84;
import 'package:coffee/src/domain/use_cases/profile_use_case/save_profile.dart'
    as _i56;
import 'package:coffee/src/domain/use_cases/profile_use_case/unlink_account_with_google.dart'
    as _i64;
import 'package:coffee/src/domain/use_cases/search_use_case/search.dart'
    as _i17;
import 'package:coffee/src/domain/use_cases/setting_use_case/delete_account.dart'
    as _i75;
import 'package:coffee/src/domain/use_cases/signup_use_case/signup_email_password.dart'
    as _i62;
import 'package:coffee/src/domain/use_cases/store_use_case/get_data_store.dart'
    as _i38;
import 'package:coffee/src/domain/use_cases/store_use_case/get_store.dart'
    as _i42;
import 'package:coffee/src/domain/use_cases/store_use_case/search_store.dart'
    as _i58;
import 'package:coffee/src/domain/use_cases/view_order_use_case/cancel_order.dart'
    as _i29;
import 'package:coffee/src/domain/use_cases/view_order_use_case/get_order.dart'
    as _i41;
import 'package:coffee/src/presentation/activity/bloc/activity_bloc.dart'
    as _i68;
import 'package:coffee/src/presentation/cart/bloc/cart_bloc.dart' as _i71;
import 'package:coffee/src/presentation/change_password/bloc/change_password_bloc.dart'
    as _i92;
import 'package:coffee/src/presentation/coupon/bloc/coupon_bloc.dart' as _i33;
import 'package:coffee/src/presentation/forgot_password/bloc/forgot_password_bloc.dart'
    as _i93;
import 'package:coffee/src/presentation/home/bloc/home_bloc.dart' as _i82;
import 'package:coffee/src/presentation/input_info/bloc/input_info_bloc.dart'
    as _i45;
import 'package:coffee/src/presentation/input_pin/bloc/input_pin_bloc.dart'
    as _i94;
import 'package:coffee/src/presentation/login/bloc/login_bloc.dart' as _i95;
import 'package:coffee/src/presentation/new_password/bloc/new_password_bloc.dart'
    as _i87;
import 'package:coffee/src/presentation/order/bloc/order_bloc.dart' as _i48;
import 'package:coffee/src/presentation/product/bloc/product_bloc.dart' as _i88;
import 'package:coffee/src/presentation/profile/bloc/profile_bloc.dart' as _i89;
import 'package:coffee/src/presentation/search/bloc/search_bloc.dart' as _i57;
import 'package:coffee/src/presentation/setting/bloc/setting_bloc.dart' as _i90;
import 'package:coffee/src/presentation/signup/bloc/signup_bloc.dart' as _i91;
import 'package:coffee/src/presentation/store/bloc/store_bloc.dart' as _i63;
import 'package:coffee/src/presentation/view_order/bloc/view_order_bloc.dart'
    as _i67;
import 'package:dio/dio.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i18;

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
    gh.lazySingleton<_i9.GetCouponUseCase>(
        () => _i9.GetCouponUseCase(gh<_i5.CouponRepository>()));
    gh.lazySingleton<_i10.InputInfoRepository>(
        () => _i11.InputInfoRepositoryImpl(gh<_i3.ApiService>()));
    gh.lazySingleton<_i12.InputInfoUseCase>(
        () => _i12.InputInfoUseCase(gh<_i10.InputInfoRepository>()));
    gh.lazySingleton<_i13.OrderRepository>(
        () => _i14.OrderRepositoryImpl(gh<_i3.ApiService>()));
    gh.lazySingleton<_i15.SearchRepository>(
        () => _i16.SearchRepositoryImpl(gh<_i3.ApiService>()));
    gh.lazySingleton<_i17.SearchUseCase>(
        () => _i17.SearchUseCase(gh<_i15.SearchRepository>()));
    await gh.lazySingletonAsync<_i18.SharedPreferences>(
      () => injectionModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i19.SignupRepository>(
        () => _i20.SignupRepositoryImpl(gh<_i3.ApiService>()));
    gh.lazySingleton<_i21.StoreDao>(() => injectionModule.storeDao);
    gh.lazySingleton<_i22.StoreRepository>(() => _i23.StoreRepositoryImpl(
          gh<_i21.StoreDao>(),
          gh<_i3.ApiService>(),
        ));
    gh.lazySingleton<_i24.UserDao>(() => injectionModule.userDao);
    gh.lazySingleton<_i25.ViewOrderRepository>(
        () => _i26.ViewOrderRepositoryImpl(
              gh<_i3.ApiService>(),
              gh<_i18.SharedPreferences>(),
            ));
    gh.lazySingleton<_i27.ActivityRepository>(() => _i28.ActivityRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i18.SharedPreferences>(),
        ));
    gh.lazySingleton<_i29.CancelOrderUseCase>(
        () => _i29.CancelOrderUseCase(gh<_i25.ViewOrderRepository>()));
    gh.lazySingleton<_i30.CartRepository>(() => _i31.CartRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i18.SharedPreferences>(),
        ));
    gh.lazySingleton<_i32.ChangeMethodUseCase>(
        () => _i32.ChangeMethodUseCase(gh<_i30.CartRepository>()));
    gh.factory<_i33.CouponBloc>(
        () => _i33.CouponBloc(gh<_i9.GetCouponUseCase>()));
    gh.lazySingleton<_i34.DeleteCouponOrderUseCase>(
        () => _i34.DeleteCouponOrderUseCase(gh<_i30.CartRepository>()));
    gh.lazySingleton<_i35.DeleteOrderSpendingUseCase>(
        () => _i35.DeleteOrderSpendingUseCase(gh<_i30.CartRepository>()));
    gh.lazySingleton<_i36.DeleteProductUseCase>(
        () => _i36.DeleteProductUseCase(gh<_i30.CartRepository>()));
    gh.lazySingleton<_i37.GetActivityUseCase>(
        () => _i37.GetActivityUseCase(gh<_i27.ActivityRepository>()));
    gh.lazySingleton<_i38.GetDataStoreUseCase>(
        () => _i38.GetDataStoreUseCase(gh<_i22.StoreRepository>()));
    gh.lazySingleton<_i39.GetListProductCatalogues>(
        () => _i39.GetListProductCatalogues(gh<_i13.OrderRepository>()));
    gh.lazySingleton<_i40.GetListProductUseCase>(
        () => _i40.GetListProductUseCase(gh<_i13.OrderRepository>()));
    gh.lazySingleton<_i41.GetOrderUserCase>(
        () => _i41.GetOrderUserCase(gh<_i25.ViewOrderRepository>()));
    gh.lazySingleton<_i42.GetStoreUseCase>(
        () => _i42.GetStoreUseCase(gh<_i22.StoreRepository>()));
    gh.lazySingleton<_i43.HomeRepository>(() => _i44.HomeRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i18.SharedPreferences>(),
          gh<_i21.StoreDao>(),
        ));
    gh.factory<_i45.InputInfoBloc>(
        () => _i45.InputInfoBloc(gh<_i12.InputInfoUseCase>()));
    gh.lazySingleton<_i46.LoginRepository>(() => _i47.LoginRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i18.SharedPreferences>(),
        ));
    gh.factory<_i48.OrderBloc>(() => _i48.OrderBloc(
          gh<_i40.GetListProductUseCase>(),
          gh<_i39.GetListProductCatalogues>(),
        ));
    gh.lazySingleton<_i49.PasswordRepository>(() => _i50.PasswordRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i18.SharedPreferences>(),
          gh<_i24.UserDao>(),
        ));
    gh.lazySingleton<_i51.PlaceOrderUseCase>(
        () => _i51.PlaceOrderUseCase(gh<_i30.CartRepository>()));
    gh.lazySingleton<_i52.ProductRepository>(() => _i53.ProductRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i18.SharedPreferences>(),
        ));
    gh.lazySingleton<_i54.ProfileRepository>(() => _i55.ProfileRepositoryImpl(
          gh<_i18.SharedPreferences>(),
          gh<_i3.ApiService>(),
        ));
    gh.lazySingleton<_i56.SaveProfileUseCase>(
        () => _i56.SaveProfileUseCase(gh<_i54.ProfileRepository>()));
    gh.factory<_i57.SearchBloc>(
        () => _i57.SearchBloc(gh<_i17.SearchUseCase>()));
    gh.lazySingleton<_i58.SearchStoreUseCase>(
        () => _i58.SearchStoreUseCase(gh<_i22.StoreRepository>()));
    gh.factory<_i59.ServiceBloc>(() => _i59.ServiceBloc(
          gh<_i18.SharedPreferences>(),
          gh<_i3.ApiService>(),
          gh<_i24.UserDao>(),
        ));
    gh.lazySingleton<_i60.SettingRepository>(() => _i61.SettingRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i18.SharedPreferences>(),
        ));
    gh.lazySingleton<_i62.SignupEmailPasswordUseCase>(
        () => _i62.SignupEmailPasswordUseCase(gh<_i19.SignupRepository>()));
    gh.factory<_i63.StoreBloc>(() => _i63.StoreBloc(
          gh<_i18.SharedPreferences>(),
          gh<_i38.GetDataStoreUseCase>(),
          gh<_i42.GetStoreUseCase>(),
          gh<_i58.SearchStoreUseCase>(),
        ));
    gh.lazySingleton<_i64.UnlinkAccountWithGoogleUseCase>(() =>
        _i64.UnlinkAccountWithGoogleUseCase(gh<_i54.ProfileRepository>()));
    gh.lazySingleton<_i65.UpdatePendingOrderUseCase>(
        () => _i65.UpdatePendingOrderUseCase(gh<_i52.ProductRepository>()));
    gh.lazySingleton<_i66.UpdateProductInOrderUseCase>(
        () => _i66.UpdateProductInOrderUseCase(gh<_i52.ProductRepository>()));
    gh.factory<_i67.ViewOrderBloc>(() => _i67.ViewOrderBloc(
          gh<_i41.GetOrderUserCase>(),
          gh<_i29.CancelOrderUseCase>(),
        ));
    gh.factory<_i68.ActivityBloc>(
        () => _i68.ActivityBloc(gh<_i37.GetActivityUseCase>()));
    gh.lazySingleton<_i69.AddNoteUseCase>(
        () => _i69.AddNoteUseCase(gh<_i30.CartRepository>()));
    gh.lazySingleton<_i70.AttachCouponToOrderUseCase>(
        () => _i70.AttachCouponToOrderUseCase(gh<_i30.CartRepository>()));
    gh.factory<_i71.CartBloc>(() => _i71.CartBloc(
          gh<_i36.DeleteProductUseCase>(),
          gh<_i51.PlaceOrderUseCase>(),
          gh<_i35.DeleteOrderSpendingUseCase>(),
          gh<_i34.DeleteCouponOrderUseCase>(),
          gh<_i32.ChangeMethodUseCase>(),
          gh<_i70.AttachCouponToOrderUseCase>(),
          gh<_i69.AddNoteUseCase>(),
        ));
    gh.lazySingleton<_i72.ChangePasswordUseCase>(
        () => _i72.ChangePasswordUseCase(gh<_i49.PasswordRepository>()));
    gh.lazySingleton<_i73.CreateNewOrderUseCase>(
        () => _i73.CreateNewOrderUseCase(gh<_i52.ProductRepository>()));
    gh.lazySingleton<_i74.CreateNewPasswordUseCase>(
        () => _i74.CreateNewPasswordUseCase(gh<_i49.PasswordRepository>()));
    gh.lazySingleton<_i75.DeleteAccountUseCase>(
        () => _i75.DeleteAccountUseCase(gh<_i60.SettingRepository>()));
    gh.lazySingleton<_i76.DeleteAvatarUseCase>(
        () => _i76.DeleteAvatarUseCase(gh<_i54.ProfileRepository>()));
    gh.factory<_i77.DeleteProductInOrderUseCase>(
        () => _i77.DeleteProductInOrderUseCase(gh<_i52.ProductRepository>()));
    gh.lazySingleton<_i78.ForgotPasswordUseCase>(
        () => _i78.ForgotPasswordUseCase(gh<_i49.PasswordRepository>()));
    gh.lazySingleton<_i79.GetCouponUseCase>(
        () => _i79.GetCouponUseCase(gh<_i43.HomeRepository>()));
    gh.lazySingleton<_i80.GetOrderSpendingUseCase>(
        () => _i80.GetOrderSpendingUseCase(gh<_i43.HomeRepository>()));
    gh.lazySingleton<_i81.GetRecommendUseCase>(
        () => _i81.GetRecommendUseCase(gh<_i43.HomeRepository>()));
    gh.factory<_i82.HomeBloc>(() => _i82.HomeBloc(
          gh<_i81.GetRecommendUseCase>(),
          gh<_i80.GetOrderSpendingUseCase>(),
          gh<_i9.GetCouponUseCase>(),
        ));
    gh.lazySingleton<_i83.InputPinUseCase>(
        () => _i83.InputPinUseCase(gh<_i49.PasswordRepository>()));
    gh.lazySingleton<_i84.LinkAccountWithGoogleUseCase>(
        () => _i84.LinkAccountWithGoogleUseCase(gh<_i54.ProfileRepository>()));
    gh.lazySingleton<_i85.LoginEmailPasswordUseCase>(
        () => _i85.LoginEmailPasswordUseCase(gh<_i46.LoginRepository>()));
    gh.lazySingleton<_i86.LoginGoogleUseCase>(
        () => _i86.LoginGoogleUseCase(gh<_i46.LoginRepository>()));
    gh.factory<_i87.NewPasswordBloc>(
        () => _i87.NewPasswordBloc(gh<_i74.CreateNewPasswordUseCase>()));
    gh.factory<_i88.ProductBloc>(() => _i88.ProductBloc(
          gh<_i65.UpdatePendingOrderUseCase>(),
          gh<_i66.UpdateProductInOrderUseCase>(),
          gh<_i77.DeleteProductInOrderUseCase>(),
          gh<_i73.CreateNewOrderUseCase>(),
        ));
    gh.factory<_i89.ProfileBloc>(() => _i89.ProfileBloc(
          gh<_i56.SaveProfileUseCase>(),
          gh<_i64.UnlinkAccountWithGoogleUseCase>(),
          gh<_i84.LinkAccountWithGoogleUseCase>(),
          gh<_i76.DeleteAvatarUseCase>(),
        ));
    gh.factory<_i90.SettingBloc>(
        () => _i90.SettingBloc(gh<_i75.DeleteAccountUseCase>()));
    gh.factory<_i91.SignUpBloc>(
        () => _i91.SignUpBloc(gh<_i62.SignupEmailPasswordUseCase>()));
    gh.factory<_i92.ChangePasswordBloc>(
        () => _i92.ChangePasswordBloc(gh<_i72.ChangePasswordUseCase>()));
    gh.factory<_i93.ForgotPasswordBloc>(
        () => _i93.ForgotPasswordBloc(gh<_i78.ForgotPasswordUseCase>()));
    gh.factory<_i94.InputPinBloc>(
        () => _i94.InputPinBloc(gh<_i83.InputPinUseCase>()));
    gh.factory<_i95.LoginBloc>(() => _i95.LoginBloc(
          gh<_i85.LoginEmailPasswordUseCase>(),
          gh<_i86.LoginGoogleUseCase>(),
        ));
    return this;
  }
}

class _$InjectionModule extends _i96.InjectionModule {}
