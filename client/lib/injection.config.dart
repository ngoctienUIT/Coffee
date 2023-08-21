// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:coffee/injection.dart' as _i101;
import 'package:coffee/src/core/services/bloc/service_bloc.dart' as _i71;
import 'package:coffee/src/data/local/dao/store_dao.dart' as _i29;
import 'package:coffee/src/data/local/dao/user_dao.dart' as _i32;
import 'package:coffee/src/data/local/database/coffee_database.dart' as _i4;
import 'package:coffee/src/data/remote/api_service/api_service.dart' as _i3;
import 'package:coffee/src/data/remote/firebase/firebase_service.dart' as _i7;
import 'package:coffee/src/data/repositories/activity_repository_impl.dart'
    as _i36;
import 'package:coffee/src/data/repositories/cart_repository_impl.dart' as _i39;
import 'package:coffee/src/data/repositories/change_password_repository_impl.dart'
    as _i42;
import 'package:coffee/src/data/repositories/coupon_repository_impl.dart'
    as _i6;
import 'package:coffee/src/data/repositories/forgot_password_repository_impl.dart'
    as _i9;
import 'package:coffee/src/data/repositories/home_repository_impl.dart' as _i56;
import 'package:coffee/src/data/repositories/input_info_repository_impl.dart'
    as _i13;
import 'package:coffee/src/data/repositories/input_pin_repository_impl.dart'
    as _i16;
import 'package:coffee/src/data/repositories/login_repository_impl.dart'
    as _i60;
import 'package:coffee/src/data/repositories/new_password_repository_impl.dart'
    as _i19;
import 'package:coffee/src/data/repositories/order_repository_impl.dart'
    as _i22;
import 'package:coffee/src/data/repositories/product_repository_impl.dart'
    as _i65;
import 'package:coffee/src/data/repositories/profile_repository_impl.dart'
    as _i67;
import 'package:coffee/src/data/repositories/search_repository_impl.dart'
    as _i24;
import 'package:coffee/src/data/repositories/setting_repository_impl.dart'
    as _i73;
import 'package:coffee/src/data/repositories/signup_repository_impl.dart'
    as _i28;
import 'package:coffee/src/data/repositories/store_repository_impl.dart'
    as _i31;
import 'package:coffee/src/data/repositories/view_order_repository_impl.dart'
    as _i34;
import 'package:coffee/src/domain/repositories/activity_repository.dart'
    as _i35;
import 'package:coffee/src/domain/repositories/cart_repository.dart' as _i38;
import 'package:coffee/src/domain/repositories/change_password_repository.dart'
    as _i41;
import 'package:coffee/src/domain/repositories/coupon_repository.dart' as _i5;
import 'package:coffee/src/domain/repositories/forgot_password_repository.dart'
    as _i8;
import 'package:coffee/src/domain/repositories/home_repository.dart' as _i55;
import 'package:coffee/src/domain/repositories/input_info_repository.dart'
    as _i12;
import 'package:coffee/src/domain/repositories/input_pin_repository.dart'
    as _i15;
import 'package:coffee/src/domain/repositories/login_repository.dart' as _i59;
import 'package:coffee/src/domain/repositories/new_password_repository.dart'
    as _i18;
import 'package:coffee/src/domain/repositories/order_repository.dart' as _i21;
import 'package:coffee/src/domain/repositories/product_repository.dart' as _i64;
import 'package:coffee/src/domain/repositories/profile_repository.dart' as _i66;
import 'package:coffee/src/domain/repositories/search_repository.dart' as _i23;
import 'package:coffee/src/domain/repositories/setting_repository.dart' as _i72;
import 'package:coffee/src/domain/repositories/signup_repository.dart' as _i27;
import 'package:coffee/src/domain/repositories/store_repository.dart' as _i30;
import 'package:coffee/src/domain/repositories/view_order_repository.dart'
    as _i33;
import 'package:coffee/src/domain/use_cases/activity_use_case/get_activity.dart'
    as _i49;
import 'package:coffee/src/domain/use_cases/cart_use_case/add_note.dart'
    as _i81;
import 'package:coffee/src/domain/use_cases/cart_use_case/attach_coupon_to_order.dart'
    as _i82;
import 'package:coffee/src/domain/use_cases/cart_use_case/change_method.dart'
    as _i40;
import 'package:coffee/src/domain/use_cases/cart_use_case/delete_coupon_order.dart'
    as _i45;
import 'package:coffee/src/domain/use_cases/cart_use_case/delete_order_spending.dart'
    as _i46;
import 'package:coffee/src/domain/use_cases/cart_use_case/delete_product.dart'
    as _i47;
import 'package:coffee/src/domain/use_cases/cart_use_case/place_oder.dart'
    as _i63;
import 'package:coffee/src/domain/use_cases/change_password_use_case/change_password.dart'
    as _i43;
import 'package:coffee/src/domain/use_cases/coupon_use_case/get_coupon.dart'
    as _i11;
import 'package:coffee/src/domain/use_cases/forgot_password_use_case/forgot_password.dart'
    as _i10;
import 'package:coffee/src/domain/use_cases/home_use_case/get_coupon.dart'
    as _i89;
import 'package:coffee/src/domain/use_cases/home_use_case/get_order_spending.dart'
    as _i90;
import 'package:coffee/src/domain/use_cases/home_use_case/get_recommend.dart'
    as _i91;
import 'package:coffee/src/domain/use_cases/input_info_use_case/input_info.dart'
    as _i14;
import 'package:coffee/src/domain/use_cases/input_pin_use_case/input_pin.dart'
    as _i17;
import 'package:coffee/src/domain/use_cases/login_use_case/login_email_password.dart'
    as _i94;
import 'package:coffee/src/domain/use_cases/login_use_case/login_google.dart'
    as _i95;
import 'package:coffee/src/domain/use_cases/new_password_use_case/new_password.dart'
    as _i20;
import 'package:coffee/src/domain/use_cases/order_use_case/get_list_product.dart'
    as _i52;
import 'package:coffee/src/domain/use_cases/order_use_case/get_list_product_catalogues.dart'
    as _i51;
import 'package:coffee/src/domain/use_cases/product_use_case/create_new_order.dart'
    as _i85;
import 'package:coffee/src/domain/use_cases/product_use_case/delete_product_in_order.dart'
    as _i88;
import 'package:coffee/src/domain/use_cases/product_use_case/update_pending_order.dart'
    as _i77;
import 'package:coffee/src/domain/use_cases/product_use_case/update_product_in_order.dart'
    as _i78;
import 'package:coffee/src/domain/use_cases/profile_use_case/delete_avatar.dart'
    as _i87;
import 'package:coffee/src/domain/use_cases/profile_use_case/link_account_with_google.dart'
    as _i93;
import 'package:coffee/src/domain/use_cases/profile_use_case/save_profile.dart'
    as _i68;
import 'package:coffee/src/domain/use_cases/profile_use_case/unlink_account_with_google.dart'
    as _i76;
import 'package:coffee/src/domain/use_cases/search_use_case/search.dart'
    as _i25;
import 'package:coffee/src/domain/use_cases/setting_use_case/delete_account.dart'
    as _i86;
import 'package:coffee/src/domain/use_cases/signup_use_case/signup_email_password.dart'
    as _i74;
import 'package:coffee/src/domain/use_cases/store_use_case/get_data_store.dart'
    as _i50;
import 'package:coffee/src/domain/use_cases/store_use_case/get_store.dart'
    as _i54;
import 'package:coffee/src/domain/use_cases/store_use_case/search_store.dart'
    as _i70;
import 'package:coffee/src/domain/use_cases/view_order_use_case/cancel_order.dart'
    as _i37;
import 'package:coffee/src/domain/use_cases/view_order_use_case/get_order.dart'
    as _i53;
import 'package:coffee/src/presentation/activity/bloc/activity_bloc.dart'
    as _i80;
import 'package:coffee/src/presentation/cart/bloc/cart_bloc.dart' as _i83;
import 'package:coffee/src/presentation/change_password/bloc/change_password_bloc.dart'
    as _i84;
import 'package:coffee/src/presentation/coupon/bloc/coupon_bloc.dart' as _i44;
import 'package:coffee/src/presentation/forgot_password/bloc/forgot_password_bloc.dart'
    as _i48;
import 'package:coffee/src/presentation/home/bloc/home_bloc.dart' as _i92;
import 'package:coffee/src/presentation/input_info/bloc/input_info_bloc.dart'
    as _i57;
import 'package:coffee/src/presentation/input_pin/bloc/input_pin_bloc.dart'
    as _i58;
import 'package:coffee/src/presentation/login/bloc/login_bloc.dart' as _i100;
import 'package:coffee/src/presentation/new_password/bloc/new_password_bloc.dart'
    as _i61;
import 'package:coffee/src/presentation/order/bloc/order_bloc.dart' as _i62;
import 'package:coffee/src/presentation/product/bloc/product_bloc.dart' as _i96;
import 'package:coffee/src/presentation/profile/bloc/profile_bloc.dart' as _i97;
import 'package:coffee/src/presentation/search/bloc/search_bloc.dart' as _i69;
import 'package:coffee/src/presentation/setting/bloc/setting_bloc.dart' as _i98;
import 'package:coffee/src/presentation/signup/bloc/signup_bloc.dart' as _i99;
import 'package:coffee/src/presentation/store/bloc/store_bloc.dart' as _i75;
import 'package:coffee/src/presentation/view_order/bloc/view_order_bloc.dart'
    as _i79;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i26;

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
    gh.lazySingleton<_i7.FirebaseService>(
        () => injectionModule.firebaseService);
    gh.lazySingleton<_i8.ForgotPasswordRepository>(
        () => _i9.ForgotPasswordRepositoryImpl(gh<_i3.ApiService>()));
    gh.lazySingleton<_i10.ForgotPasswordUseCase>(
        () => _i10.ForgotPasswordUseCase(gh<_i8.ForgotPasswordRepository>()));
    gh.lazySingleton<_i11.GetCouponUseCase>(
        () => _i11.GetCouponUseCase(gh<_i5.CouponRepository>()));
    gh.lazySingleton<_i12.InputInfoRepository>(
        () => _i13.InputInfoRepositoryImpl(gh<_i3.ApiService>()));
    gh.lazySingleton<_i14.InputInfoUseCase>(
        () => _i14.InputInfoUseCase(gh<_i12.InputInfoRepository>()));
    gh.lazySingleton<_i15.InputPinRepository>(
        () => _i16.InputPinRepositoryImpl(gh<_i3.ApiService>()));
    gh.lazySingleton<_i17.InputPinUseCase>(
        () => _i17.InputPinUseCase(gh<_i15.InputPinRepository>()));
    gh.lazySingleton<_i18.NewPasswordRepository>(
        () => _i19.NewPasswordRepositoryImpl(gh<_i3.ApiService>()));
    gh.lazySingleton<_i20.NewPasswordUseCase>(
        () => _i20.NewPasswordUseCase(gh<_i18.NewPasswordRepository>()));
    gh.lazySingleton<_i21.OrderRepository>(
        () => _i22.OrderRepositoryImpl(gh<_i3.ApiService>()));
    gh.lazySingleton<_i23.SearchRepository>(
        () => _i24.SearchRepositoryImpl(gh<_i3.ApiService>()));
    gh.lazySingleton<_i25.SearchUseCase>(
        () => _i25.SearchUseCase(gh<_i23.SearchRepository>()));
    await gh.lazySingletonAsync<_i26.SharedPreferences>(
      () => injectionModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i27.SignupRepository>(
        () => _i28.SignupRepositoryImpl(gh<_i3.ApiService>()));
    gh.lazySingleton<_i29.StoreDao>(() => injectionModule.storeDao);
    gh.lazySingleton<_i30.StoreRepository>(() => _i31.StoreRepositoryImpl(
          gh<_i29.StoreDao>(),
          gh<_i3.ApiService>(),
        ));
    gh.lazySingleton<_i32.UserDao>(() => injectionModule.userDao);
    gh.lazySingleton<_i33.ViewOrderRepository>(
        () => _i34.ViewOrderRepositoryImpl(
              gh<_i3.ApiService>(),
              gh<_i26.SharedPreferences>(),
            ));
    gh.lazySingleton<_i35.ActivityRepository>(() => _i36.ActivityRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i26.SharedPreferences>(),
        ));
    gh.lazySingleton<_i37.CancelOrderUseCase>(
        () => _i37.CancelOrderUseCase(gh<_i33.ViewOrderRepository>()));
    gh.lazySingleton<_i38.CartRepository>(() => _i39.CartRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i26.SharedPreferences>(),
        ));
    gh.lazySingleton<_i40.ChangeMethodUseCase>(
        () => _i40.ChangeMethodUseCase(gh<_i38.CartRepository>()));
    gh.lazySingleton<_i41.ChangePasswordRepository>(
        () => _i42.ChangePasswordRepositoryImpl(
              gh<_i3.ApiService>(),
              gh<_i26.SharedPreferences>(),
              gh<_i32.UserDao>(),
            ));
    gh.lazySingleton<_i43.ChangePasswordUseCase>(
        () => _i43.ChangePasswordUseCase(gh<_i41.ChangePasswordRepository>()));
    gh.factory<_i44.CouponBloc>(
        () => _i44.CouponBloc(gh<_i11.GetCouponUseCase>()));
    gh.lazySingleton<_i45.DeleteCouponOrderUseCase>(
        () => _i45.DeleteCouponOrderUseCase(gh<_i38.CartRepository>()));
    gh.lazySingleton<_i46.DeleteOrderSpendingUseCase>(
        () => _i46.DeleteOrderSpendingUseCase(gh<_i38.CartRepository>()));
    gh.lazySingleton<_i47.DeleteProductUseCase>(
        () => _i47.DeleteProductUseCase(gh<_i38.CartRepository>()));
    gh.factory<_i48.ForgotPasswordBloc>(
        () => _i48.ForgotPasswordBloc(gh<_i10.ForgotPasswordUseCase>()));
    gh.lazySingleton<_i49.GetActivityUseCase>(
        () => _i49.GetActivityUseCase(gh<_i35.ActivityRepository>()));
    gh.lazySingleton<_i50.GetDataStoreUseCase>(
        () => _i50.GetDataStoreUseCase(gh<_i30.StoreRepository>()));
    gh.lazySingleton<_i51.GetListProductCatalogues>(
        () => _i51.GetListProductCatalogues(gh<_i21.OrderRepository>()));
    gh.lazySingleton<_i52.GetListProductUseCase>(
        () => _i52.GetListProductUseCase(gh<_i21.OrderRepository>()));
    gh.lazySingleton<_i53.GetOrderUserCase>(
        () => _i53.GetOrderUserCase(gh<_i33.ViewOrderRepository>()));
    gh.lazySingleton<_i54.GetStoreUseCase>(
        () => _i54.GetStoreUseCase(gh<_i30.StoreRepository>()));
    gh.lazySingleton<_i55.HomeRepository>(() => _i56.HomeRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i26.SharedPreferences>(),
        ));
    gh.factory<_i57.InputInfoBloc>(
        () => _i57.InputInfoBloc(gh<_i14.InputInfoUseCase>()));
    gh.factory<_i58.InputPinBloc>(
        () => _i58.InputPinBloc(gh<_i17.InputPinUseCase>()));
    gh.lazySingleton<_i59.LoginRepository>(() => _i60.LoginRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i26.SharedPreferences>(),
        ));
    gh.factory<_i61.NewPasswordBloc>(
        () => _i61.NewPasswordBloc(gh<_i20.NewPasswordUseCase>()));
    gh.factory<_i62.OrderBloc>(() => _i62.OrderBloc(
          gh<_i52.GetListProductUseCase>(),
          gh<_i51.GetListProductCatalogues>(),
        ));
    gh.lazySingleton<_i63.PlaceOrderUseCase>(
        () => _i63.PlaceOrderUseCase(gh<_i38.CartRepository>()));
    gh.lazySingleton<_i64.ProductRepository>(() => _i65.ProductRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i26.SharedPreferences>(),
        ));
    gh.lazySingleton<_i66.ProfileRepository>(() => _i67.ProfileRepositoryImpl(
          gh<_i26.SharedPreferences>(),
          gh<_i3.ApiService>(),
        ));
    gh.lazySingleton<_i68.SaveProfileUseCase>(
        () => _i68.SaveProfileUseCase(gh<_i66.ProfileRepository>()));
    gh.factory<_i69.SearchBloc>(
        () => _i69.SearchBloc(gh<_i25.SearchUseCase>()));
    gh.lazySingleton<_i70.SearchStoreUseCase>(
        () => _i70.SearchStoreUseCase(gh<_i30.StoreRepository>()));
    gh.factory<_i71.ServiceBloc>(
        () => _i71.ServiceBloc(gh<_i26.SharedPreferences>()));
    gh.lazySingleton<_i72.SettingRepository>(() => _i73.SettingRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i26.SharedPreferences>(),
        ));
    gh.lazySingleton<_i74.SignupEmailPasswordUseCase>(
        () => _i74.SignupEmailPasswordUseCase(gh<_i27.SignupRepository>()));
    gh.factory<_i75.StoreBloc>(() => _i75.StoreBloc(
          gh<_i26.SharedPreferences>(),
          gh<_i50.GetDataStoreUseCase>(),
          gh<_i54.GetStoreUseCase>(),
          gh<_i70.SearchStoreUseCase>(),
        ));
    gh.lazySingleton<_i76.UnlinkAccountWithGoogleUseCase>(() =>
        _i76.UnlinkAccountWithGoogleUseCase(gh<_i66.ProfileRepository>()));
    gh.lazySingleton<_i77.UpdatePendingOrderUseCase>(
        () => _i77.UpdatePendingOrderUseCase(gh<_i64.ProductRepository>()));
    gh.lazySingleton<_i78.UpdateProductInOrderUseCase>(
        () => _i78.UpdateProductInOrderUseCase(gh<_i64.ProductRepository>()));
    gh.factory<_i79.ViewOrderBloc>(() => _i79.ViewOrderBloc(
          gh<_i53.GetOrderUserCase>(),
          gh<_i37.CancelOrderUseCase>(),
        ));
    gh.factory<_i80.ActivityBloc>(
        () => _i80.ActivityBloc(gh<_i49.GetActivityUseCase>()));
    gh.lazySingleton<_i81.AddNoteUseCase>(
        () => _i81.AddNoteUseCase(gh<_i38.CartRepository>()));
    gh.lazySingleton<_i82.AttachCouponToOrderUseCase>(
        () => _i82.AttachCouponToOrderUseCase(gh<_i38.CartRepository>()));
    gh.factory<_i83.CartBloc>(() => _i83.CartBloc(
          gh<_i47.DeleteProductUseCase>(),
          gh<_i63.PlaceOrderUseCase>(),
          gh<_i46.DeleteOrderSpendingUseCase>(),
          gh<_i45.DeleteCouponOrderUseCase>(),
          gh<_i40.ChangeMethodUseCase>(),
          gh<_i82.AttachCouponToOrderUseCase>(),
          gh<_i81.AddNoteUseCase>(),
        ));
    gh.factory<_i84.ChangePasswordBloc>(
        () => _i84.ChangePasswordBloc(gh<_i43.ChangePasswordUseCase>()));
    gh.lazySingleton<_i85.CreateNewOrderUseCase>(
        () => _i85.CreateNewOrderUseCase(gh<_i64.ProductRepository>()));
    gh.lazySingleton<_i86.DeleteAccountUseCase>(
        () => _i86.DeleteAccountUseCase(gh<_i72.SettingRepository>()));
    gh.lazySingleton<_i87.DeleteAvatarUseCase>(
        () => _i87.DeleteAvatarUseCase(gh<_i66.ProfileRepository>()));
    gh.factory<_i88.DeleteProductInOrderUseCase>(
        () => _i88.DeleteProductInOrderUseCase(gh<_i64.ProductRepository>()));
    gh.lazySingleton<_i89.GetCouponUseCase>(
        () => _i89.GetCouponUseCase(gh<_i55.HomeRepository>()));
    gh.lazySingleton<_i90.GetOrderSpendingUseCase>(
        () => _i90.GetOrderSpendingUseCase(gh<_i55.HomeRepository>()));
    gh.lazySingleton<_i91.GetRecommendUseCase>(
        () => _i91.GetRecommendUseCase(gh<_i55.HomeRepository>()));
    gh.factory<_i92.HomeBloc>(() => _i92.HomeBloc(
          gh<_i91.GetRecommendUseCase>(),
          gh<_i90.GetOrderSpendingUseCase>(),
          gh<_i11.GetCouponUseCase>(),
        ));
    gh.lazySingleton<_i93.LinkAccountWithGoogleUseCase>(
        () => _i93.LinkAccountWithGoogleUseCase(gh<_i66.ProfileRepository>()));
    gh.lazySingleton<_i94.LoginEmailPasswordUseCase>(
        () => _i94.LoginEmailPasswordUseCase(gh<_i59.LoginRepository>()));
    gh.lazySingleton<_i95.LoginGoogleUseCase>(
        () => _i95.LoginGoogleUseCase(gh<_i59.LoginRepository>()));
    gh.factory<_i96.ProductBloc>(() => _i96.ProductBloc(
          gh<_i77.UpdatePendingOrderUseCase>(),
          gh<_i78.UpdateProductInOrderUseCase>(),
          gh<_i88.DeleteProductInOrderUseCase>(),
          gh<_i85.CreateNewOrderUseCase>(),
        ));
    gh.factory<_i97.ProfileBloc>(() => _i97.ProfileBloc(
          gh<_i68.SaveProfileUseCase>(),
          gh<_i76.UnlinkAccountWithGoogleUseCase>(),
          gh<_i93.LinkAccountWithGoogleUseCase>(),
          gh<_i87.DeleteAvatarUseCase>(),
        ));
    gh.factory<_i98.SettingBloc>(
        () => _i98.SettingBloc(gh<_i86.DeleteAccountUseCase>()));
    gh.factory<_i99.SignUpBloc>(
        () => _i99.SignUpBloc(gh<_i74.SignupEmailPasswordUseCase>()));
    gh.factory<_i100.LoginBloc>(() => _i100.LoginBloc(
          gh<_i94.LoginEmailPasswordUseCase>(),
          gh<_i95.LoginGoogleUseCase>(),
        ));
    return this;
  }
}

class _$InjectionModule extends _i101.InjectionModule {}
