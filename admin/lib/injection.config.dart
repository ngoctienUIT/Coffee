// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:coffee_admin/injection.dart' as _i109;
import 'package:coffee_admin/src/data/local/dao/store_dao.dart' as _i13;
import 'package:coffee_admin/src/data/local/dao/user_dao.dart' as _i23;
import 'package:coffee_admin/src/data/local/database/coffee_database.dart'
    as _i4;
import 'package:coffee_admin/src/data/remote/api_service/api_service.dart'
    as _i3;
import 'package:coffee_admin/src/data/remote/firebase/firebase_service.dart'
    as _i6;
import 'package:coffee_admin/src/data/repositories/account_management_repository_impl.dart'
    as _i25;
import 'package:coffee_admin/src/data/repositories/coupon_repository_impl.dart'
    as _i27;
import 'package:coffee_admin/src/data/repositories/login_repository_impl.dart'
    as _i44;
import 'package:coffee_admin/src/data/repositories/order_repository_impl.dart'
    as _i46;
import 'package:coffee_admin/src/data/repositories/password_repository_impl.dart'
    as _i48;
import 'package:coffee_admin/src/data/repositories/product_catalogues_repository_impl.dart'
    as _i50;
import 'package:coffee_admin/src/data/repositories/product_repository_impl.dart'
    as _i52;
import 'package:coffee_admin/src/data/repositories/profile_repository_impl.dart'
    as _i54;
import 'package:coffee_admin/src/data/repositories/recomment_repository_impl.dart'
    as _i56;
import 'package:coffee_admin/src/data/repositories/search_repository_impl.dart'
    as _i8;
import 'package:coffee_admin/src/data/repositories/setting_repository_impl.dart'
    as _i60;
import 'package:coffee_admin/src/data/repositories/signup_repository_impl.dart'
    as _i12;
import 'package:coffee_admin/src/data/repositories/store_repository_impl.dart'
    as _i15;
import 'package:coffee_admin/src/data/repositories/tag_repository_impl.dart'
    as _i17;
import 'package:coffee_admin/src/data/repositories/topping_repository_impl.dart'
    as _i19;
import 'package:coffee_admin/src/domain/repositories/account_management_repository.dart'
    as _i24;
import 'package:coffee_admin/src/domain/repositories/coupon_repository.dart'
    as _i26;
import 'package:coffee_admin/src/domain/repositories/login_repository.dart'
    as _i43;
import 'package:coffee_admin/src/domain/repositories/order_repository.dart'
    as _i45;
import 'package:coffee_admin/src/domain/repositories/password_repository.dart'
    as _i47;
import 'package:coffee_admin/src/domain/repositories/product_catalogues_repository.dart'
    as _i49;
import 'package:coffee_admin/src/domain/repositories/product_repository.dart'
    as _i51;
import 'package:coffee_admin/src/domain/repositories/profile_repository.dart'
    as _i53;
import 'package:coffee_admin/src/domain/repositories/recommend_repository.dart'
    as _i55;
import 'package:coffee_admin/src/domain/repositories/search_repository.dart'
    as _i7;
import 'package:coffee_admin/src/domain/repositories/setting_repository.dart'
    as _i59;
import 'package:coffee_admin/src/domain/repositories/signup_repository.dart'
    as _i11;
import 'package:coffee_admin/src/domain/repositories/store_repository.dart'
    as _i14;
import 'package:coffee_admin/src/domain/repositories/tag_repository.dart'
    as _i16;
import 'package:coffee_admin/src/domain/repositories/topping_repository.dart'
    as _i18;
import 'package:coffee_admin/src/domain/use_cases/account_management_use_case/delete_account.dart'
    as _i32;
import 'package:coffee_admin/src/domain/use_cases/account_management_use_case/get_all_account.dart'
    as _i38;
import 'package:coffee_admin/src/domain/use_cases/coupon_use_case/create_coupon.dart'
    as _i28;
import 'package:coffee_admin/src/domain/use_cases/coupon_use_case/delete_coupon.dart'
    as _i33;
import 'package:coffee_admin/src/domain/use_cases/coupon_use_case/get_all_coupon.dart'
    as _i39;
import 'package:coffee_admin/src/domain/use_cases/coupon_use_case/update_coupon.dart'
    as _i65;
import 'package:coffee_admin/src/domain/use_cases/login/login_email_password.dart'
    as _i93;
import 'package:coffee_admin/src/domain/use_cases/order_use_case/cancel_order.dart'
    as _i74;
import 'package:coffee_admin/src/domain/use_cases/order_use_case/get_list_order.dart'
    as _i87;
import 'package:coffee_admin/src/domain/use_cases/order_use_case/get_order_by_id.dart'
    as _i88;
import 'package:coffee_admin/src/domain/use_cases/order_use_case/order_completed.dart'
    as _i96;
import 'package:coffee_admin/src/domain/use_cases/password_use_case/change_password.dart'
    as _i75;
import 'package:coffee_admin/src/domain/use_cases/password_use_case/create_new_password.dart'
    as _i77;
import 'package:coffee_admin/src/domain/use_cases/password_use_case/forgot_password.dart'
    as _i86;
import 'package:coffee_admin/src/domain/use_cases/password_use_case/input_pin.dart'
    as _i92;
import 'package:coffee_admin/src/domain/use_cases/product_catalogues_use_case/create_product_catalogues.dart'
    as _i78;
import 'package:coffee_admin/src/domain/use_cases/product_catalogues_use_case/delete_product_catalogues.dart'
    as _i83;
import 'package:coffee_admin/src/domain/use_cases/product_catalogues_use_case/get_product_catalogues.dart'
    as _i89;
import 'package:coffee_admin/src/domain/use_cases/product_catalogues_use_case/update_product_catalogues.dart'
    as _i66;
import 'package:coffee_admin/src/domain/use_cases/product_use_case/create_product.dart'
    as _i79;
import 'package:coffee_admin/src/domain/use_cases/product_use_case/delete_product.dart'
    as _i84;
import 'package:coffee_admin/src/domain/use_cases/product_use_case/get_product.dart'
    as _i90;
import 'package:coffee_admin/src/domain/use_cases/product_use_case/update_product.dart'
    as _i67;
import 'package:coffee_admin/src/domain/use_cases/profile_use_case/delete_avatar.dart'
    as _i82;
import 'package:coffee_admin/src/domain/use_cases/profile_use_case/save_profile.dart'
    as _i57;
import 'package:coffee_admin/src/domain/use_cases/recommend_use_case/create_recommend.dart'
    as _i80;
import 'package:coffee_admin/src/domain/use_cases/recommend_use_case/delete_recommend.dart'
    as _i85;
import 'package:coffee_admin/src/domain/use_cases/recommend_use_case/get_recommend.dart'
    as _i91;
import 'package:coffee_admin/src/domain/use_cases/recommend_use_case/update_recommend.dart'
    as _i68;
import 'package:coffee_admin/src/domain/use_cases/search_use_case/search_product.dart'
    as _i58;
import 'package:coffee_admin/src/domain/use_cases/search_use_case/search_staff.dart'
    as _i9;
import 'package:coffee_admin/src/domain/use_cases/setting_use_case/delete_account.dart'
    as _i81;
import 'package:coffee_admin/src/domain/use_cases/signup_use_case/signup_email_password.dart'
    as _i61;
import 'package:coffee_admin/src/domain/use_cases/store_use_case/create_store.dart'
    as _i29;
import 'package:coffee_admin/src/domain/use_cases/store_use_case/delete_store.dart'
    as _i34;
import 'package:coffee_admin/src/domain/use_cases/store_use_case/fetch_store.dart'
    as _i37;
import 'package:coffee_admin/src/domain/use_cases/store_use_case/get_store.dart'
    as _i40;
import 'package:coffee_admin/src/domain/use_cases/store_use_case/update_store.dart'
    as _i20;
import 'package:coffee_admin/src/domain/use_cases/tag_use_case/create_tag.dart'
    as _i30;
import 'package:coffee_admin/src/domain/use_cases/tag_use_case/delete_tag.dart'
    as _i35;
import 'package:coffee_admin/src/domain/use_cases/tag_use_case/get_tag.dart'
    as _i41;
import 'package:coffee_admin/src/domain/use_cases/tag_use_case/update_tag.dart'
    as _i21;
import 'package:coffee_admin/src/domain/use_cases/topping_use_case/create_topping.dart'
    as _i31;
import 'package:coffee_admin/src/domain/use_cases/topping_use_case/delete_topping.dart'
    as _i36;
import 'package:coffee_admin/src/domain/use_cases/topping_use_case/get_topping.dart'
    as _i42;
import 'package:coffee_admin/src/domain/use_cases/topping_use_case/update_topping.dart'
    as _i22;
import 'package:coffee_admin/src/presentation/account_management/bloc/account_bloc.dart'
    as _i69;
import 'package:coffee_admin/src/presentation/add_coupon/bloc/add_coupon_bloc.dart'
    as _i70;
import 'package:coffee_admin/src/presentation/add_product/bloc/add_product_bloc.dart'
    as _i103;
import 'package:coffee_admin/src/presentation/add_product_catalogues/bloc/add_product_catalogues_bloc.dart'
    as _i104;
import 'package:coffee_admin/src/presentation/add_recommend/bloc/add_recommend_bloc.dart'
    as _i105;
import 'package:coffee_admin/src/presentation/add_store/bloc/add_store_bloc.dart'
    as _i71;
import 'package:coffee_admin/src/presentation/add_tag/bloc/add_tag_bloc.dart'
    as _i72;
import 'package:coffee_admin/src/presentation/add_topping/bloc/add_topping_bloc.dart'
    as _i73;
import 'package:coffee_admin/src/presentation/change_password/bloc/change_password_bloc.dart'
    as _i106;
import 'package:coffee_admin/src/presentation/coupon/bloc/coupon_bloc.dart'
    as _i76;
import 'package:coffee_admin/src/presentation/forgot_password/bloc/forgot_password_bloc.dart'
    as _i107;
import 'package:coffee_admin/src/presentation/login/bloc/login_bloc.dart'
    as _i108;
import 'package:coffee_admin/src/presentation/new_password/bloc/new_password_bloc.dart'
    as _i94;
import 'package:coffee_admin/src/presentation/order/bloc/order_bloc.dart'
    as _i95;
import 'package:coffee_admin/src/presentation/product/bloc/product_bloc.dart'
    as _i97;
import 'package:coffee_admin/src/presentation/product_catalogues/bloc/product_catalogues_bloc.dart'
    as _i98;
import 'package:coffee_admin/src/presentation/profile/bloc/profile_bloc.dart'
    as _i99;
import 'package:coffee_admin/src/presentation/recommend/bloc/recommend_bloc.dart'
    as _i100;
import 'package:coffee_admin/src/presentation/signup/bloc/signup_bloc.dart'
    as _i101;
import 'package:coffee_admin/src/presentation/store/bloc/store_bloc.dart'
    as _i62;
import 'package:coffee_admin/src/presentation/tag/bloc/tag_bloc.dart' as _i63;
import 'package:coffee_admin/src/presentation/topping/bloc/topping_bloc.dart'
    as _i64;
import 'package:coffee_admin/src/presentation/view_order/bloc/view_order_bloc.dart'
    as _i102;
import 'package:dio/dio.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i10;

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
    gh.lazySingleton<_i5.Dio>(() => injectionModule.dio);
    gh.lazySingleton<_i6.FirebaseService>(
        () => injectionModule.firebaseService);
    gh.lazySingleton<_i7.SearchRepository>(
        () => _i8.SearchRepositoryImpl(gh<_i3.ApiService>()));
    gh.lazySingleton<_i9.SearchStaffUseCase>(
        () => _i9.SearchStaffUseCase(gh<_i7.SearchRepository>()));
    await gh.lazySingletonAsync<_i10.SharedPreferences>(
      () => injectionModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i11.SignUpRepository>(
        () => _i12.SignUpRepositoryImpl(gh<_i3.ApiService>()));
    gh.lazySingleton<_i13.StoreDao>(() => injectionModule.storeDao);
    gh.lazySingleton<_i14.StoreRepository>(() => _i15.StoreRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i10.SharedPreferences>(),
          gh<_i13.StoreDao>(),
        ));
    gh.lazySingleton<_i16.TagRepository>(() => _i17.TagRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i10.SharedPreferences>(),
        ));
    gh.lazySingleton<_i18.ToppingRepository>(() => _i19.ToppingRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i10.SharedPreferences>(),
        ));
    gh.lazySingleton<_i20.UpdateStoreUseCase>(
        () => _i20.UpdateStoreUseCase(gh<_i14.StoreRepository>()));
    gh.lazySingleton<_i21.UpdateTagUseCase>(
        () => _i21.UpdateTagUseCase(gh<_i16.TagRepository>()));
    gh.lazySingleton<_i22.UpdateToppingUseCase>(
        () => _i22.UpdateToppingUseCase(gh<_i18.ToppingRepository>()));
    gh.lazySingleton<_i23.UserDao>(() => injectionModule.userDao);
    gh.lazySingleton<_i24.AccountManagementRepository>(
        () => _i25.AccountManagementRepositoryImpl(
              gh<_i3.ApiService>(),
              gh<_i10.SharedPreferences>(),
            ));
    gh.lazySingleton<_i26.CouponRepository>(() => _i27.CouponRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i10.SharedPreferences>(),
        ));
    gh.lazySingleton<_i28.CreateCouponUseCase>(
        () => _i28.CreateCouponUseCase(gh<_i26.CouponRepository>()));
    gh.lazySingleton<_i29.CreateStoreUseCase>(
        () => _i29.CreateStoreUseCase(gh<_i14.StoreRepository>()));
    gh.lazySingleton<_i30.CreateTagUseCase>(
        () => _i30.CreateTagUseCase(gh<_i16.TagRepository>()));
    gh.lazySingleton<_i31.CreateToppingUseCase>(
        () => _i31.CreateToppingUseCase(gh<_i18.ToppingRepository>()));
    gh.lazySingleton<_i32.DeleteAccountUseCase>(() =>
        _i32.DeleteAccountUseCase(gh<_i24.AccountManagementRepository>()));
    gh.lazySingleton<_i33.DeleteCouponUseCase>(
        () => _i33.DeleteCouponUseCase(gh<_i26.CouponRepository>()));
    gh.lazySingleton<_i34.DeleteStoreUseCase>(
        () => _i34.DeleteStoreUseCase(gh<_i14.StoreRepository>()));
    gh.lazySingleton<_i35.DeleteTagUseCase>(
        () => _i35.DeleteTagUseCase(gh<_i16.TagRepository>()));
    gh.lazySingleton<_i36.DeleteToppingUseCase>(
        () => _i36.DeleteToppingUseCase(gh<_i18.ToppingRepository>()));
    gh.lazySingleton<_i37.FetchStoreUseCase>(
        () => _i37.FetchStoreUseCase(gh<_i14.StoreRepository>()));
    gh.lazySingleton<_i38.GetAllAccountUseCase>(() =>
        _i38.GetAllAccountUseCase(gh<_i24.AccountManagementRepository>()));
    gh.lazySingleton<_i39.GetAllCouponUseCase>(
        () => _i39.GetAllCouponUseCase(gh<_i26.CouponRepository>()));
    gh.lazySingleton<_i40.GetStoreUseCase>(
        () => _i40.GetStoreUseCase(gh<_i14.StoreRepository>()));
    gh.lazySingleton<_i41.GetTagUseCase>(
        () => _i41.GetTagUseCase(gh<_i16.TagRepository>()));
    gh.lazySingleton<_i42.GetToppingUseCase>(
        () => _i42.GetToppingUseCase(gh<_i18.ToppingRepository>()));
    gh.lazySingleton<_i43.LoginRepository>(() => _i44.LoginRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i10.SharedPreferences>(),
        ));
    gh.lazySingleton<_i45.OrderRepository>(() => _i46.OrderRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i10.SharedPreferences>(),
          gh<_i23.UserDao>(),
        ));
    gh.lazySingleton<_i47.PasswordRepository>(() => _i48.PasswordRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i10.SharedPreferences>(),
        ));
    gh.lazySingleton<_i49.ProductCataloguesRepository>(
        () => _i50.ProductCataloguesRepositoryImpl(
              gh<_i3.ApiService>(),
              gh<_i10.SharedPreferences>(),
            ));
    gh.lazySingleton<_i51.ProductRepository>(() => _i52.ProductRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i10.SharedPreferences>(),
        ));
    gh.lazySingleton<_i53.ProfileRepository>(() => _i54.ProfileRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i10.SharedPreferences>(),
        ));
    gh.lazySingleton<_i55.RecommendRepository>(
        () => _i56.RecommendRepositoryImpl(
              gh<_i3.ApiService>(),
              gh<_i10.SharedPreferences>(),
            ));
    gh.lazySingleton<_i57.SaveProfileUseCase>(
        () => _i57.SaveProfileUseCase(gh<_i53.ProfileRepository>()));
    gh.lazySingleton<_i58.SearchProductUseCase>(
        () => _i58.SearchProductUseCase(gh<_i7.SearchRepository>()));
    gh.lazySingleton<_i59.SettingRepository>(() => _i60.SettingRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i10.SharedPreferences>(),
        ));
    gh.lazySingleton<_i61.SignUpEmailPasswordUseCase>(
        () => _i61.SignUpEmailPasswordUseCase(gh<_i11.SignUpRepository>()));
    gh.factory<_i62.StoreBloc>(() => _i62.StoreBloc(
          gh<_i34.DeleteStoreUseCase>(),
          gh<_i40.GetStoreUseCase>(),
        ));
    gh.factory<_i63.TagBloc>(() => _i63.TagBloc(
          gh<_i41.GetTagUseCase>(),
          gh<_i35.DeleteTagUseCase>(),
        ));
    gh.factory<_i64.ToppingBloc>(() => _i64.ToppingBloc(
          gh<_i42.GetToppingUseCase>(),
          gh<_i36.DeleteToppingUseCase>(),
        ));
    gh.lazySingleton<_i65.UpdateCouponUseCase>(
        () => _i65.UpdateCouponUseCase(gh<_i26.CouponRepository>()));
    gh.lazySingleton<_i66.UpdateProductCataloguesUseCase>(() =>
        _i66.UpdateProductCataloguesUseCase(
            gh<_i49.ProductCataloguesRepository>()));
    gh.lazySingleton<_i67.UpdateProductUseCase>(
        () => _i67.UpdateProductUseCase(gh<_i51.ProductRepository>()));
    gh.lazySingleton<_i68.UpdateRecommendUseCase>(
        () => _i68.UpdateRecommendUseCase(gh<_i55.RecommendRepository>()));
    gh.factory<_i69.AccountBloc>(() => _i69.AccountBloc(
          gh<_i32.DeleteAccountUseCase>(),
          gh<_i38.GetAllAccountUseCase>(),
        ));
    gh.factory<_i70.AddCouponBloc>(() => _i70.AddCouponBloc(
          gh<_i28.CreateCouponUseCase>(),
          gh<_i65.UpdateCouponUseCase>(),
        ));
    gh.factory<_i71.AddStoreBloc>(() => _i71.AddStoreBloc(
          gh<_i29.CreateStoreUseCase>(),
          gh<_i20.UpdateStoreUseCase>(),
        ));
    gh.factory<_i72.AddTagBloc>(() => _i72.AddTagBloc(
          gh<_i30.CreateTagUseCase>(),
          gh<_i21.UpdateTagUseCase>(),
        ));
    gh.factory<_i73.AddToppingBloc>(() => _i73.AddToppingBloc(
          gh<_i31.CreateToppingUseCase>(),
          gh<_i22.UpdateToppingUseCase>(),
        ));
    gh.lazySingleton<_i74.CancelOrderUseCase>(
        () => _i74.CancelOrderUseCase(gh<_i45.OrderRepository>()));
    gh.lazySingleton<_i75.ChangePasswordUseCase>(
        () => _i75.ChangePasswordUseCase(gh<_i47.PasswordRepository>()));
    gh.factory<_i76.CouponBloc>(() => _i76.CouponBloc(
          gh<_i39.GetAllCouponUseCase>(),
          gh<_i33.DeleteCouponUseCase>(),
        ));
    gh.lazySingleton<_i77.CreateNewPasswordUseCase>(
        () => _i77.CreateNewPasswordUseCase(gh<_i47.PasswordRepository>()));
    gh.lazySingleton<_i78.CreateProductCataloguesUseCase>(() =>
        _i78.CreateProductCataloguesUseCase(
            gh<_i49.ProductCataloguesRepository>()));
    gh.lazySingleton<_i79.CreateProductUseCase>(
        () => _i79.CreateProductUseCase(gh<_i51.ProductRepository>()));
    gh.lazySingleton<_i80.CreateRecommendUseCase>(
        () => _i80.CreateRecommendUseCase(gh<_i55.RecommendRepository>()));
    gh.lazySingleton<_i81.DeleteAccountUseCase>(
        () => _i81.DeleteAccountUseCase(gh<_i59.SettingRepository>()));
    gh.lazySingleton<_i82.DeleteAvatarUseCase>(
        () => _i82.DeleteAvatarUseCase(gh<_i53.ProfileRepository>()));
    gh.lazySingleton<_i83.DeleteProductCataloguesUseCase>(() =>
        _i83.DeleteProductCataloguesUseCase(
            gh<_i49.ProductCataloguesRepository>()));
    gh.lazySingleton<_i84.DeleteProductUseCase>(
        () => _i84.DeleteProductUseCase(gh<_i51.ProductRepository>()));
    gh.lazySingleton<_i85.DeleteRecommendUseCase>(
        () => _i85.DeleteRecommendUseCase(gh<_i55.RecommendRepository>()));
    gh.lazySingleton<_i86.ForgotPasswordUseCase>(
        () => _i86.ForgotPasswordUseCase(gh<_i47.PasswordRepository>()));
    gh.lazySingleton<_i87.GetListOrderUseCase>(
        () => _i87.GetListOrderUseCase(gh<_i45.OrderRepository>()));
    gh.lazySingleton<_i88.GetOrderByIDUseCase>(
        () => _i88.GetOrderByIDUseCase(gh<_i45.OrderRepository>()));
    gh.lazySingleton<_i89.GetProductCataloguesUseCase>(() =>
        _i89.GetProductCataloguesUseCase(
            gh<_i49.ProductCataloguesRepository>()));
    gh.lazySingleton<_i90.GetProductUseCase>(
        () => _i90.GetProductUseCase(gh<_i51.ProductRepository>()));
    gh.lazySingleton<_i91.GetRecommendUseCase>(
        () => _i91.GetRecommendUseCase(gh<_i55.RecommendRepository>()));
    gh.lazySingleton<_i92.InputPinUseCase>(
        () => _i92.InputPinUseCase(gh<_i47.PasswordRepository>()));
    gh.lazySingleton<_i93.LoginEmailPasswordUseCase>(
        () => _i93.LoginEmailPasswordUseCase(gh<_i43.LoginRepository>()));
    gh.factory<_i94.NewPasswordBloc>(
        () => _i94.NewPasswordBloc(gh<_i77.CreateNewPasswordUseCase>()));
    gh.factory<_i95.OrderBloc>(
        () => _i95.OrderBloc(gh<_i87.GetListOrderUseCase>()));
    gh.lazySingleton<_i96.OrderCompletedUseCase>(
        () => _i96.OrderCompletedUseCase(gh<_i45.OrderRepository>()));
    gh.factory<_i97.ProductBloc>(() => _i97.ProductBloc(
          gh<_i84.DeleteProductUseCase>(),
          gh<_i90.GetProductUseCase>(),
          gh<_i89.GetProductCataloguesUseCase>(),
        ));
    gh.factory<_i98.ProductCataloguesBloc>(() => _i98.ProductCataloguesBloc(
          gh<_i89.GetProductCataloguesUseCase>(),
          gh<_i83.DeleteProductCataloguesUseCase>(),
        ));
    gh.factory<_i99.ProfileBloc>(() => _i99.ProfileBloc(
          gh<_i57.SaveProfileUseCase>(),
          gh<_i82.DeleteAvatarUseCase>(),
        ));
    gh.factory<_i100.RecommendBloc>(() => _i100.RecommendBloc(
          gh<_i91.GetRecommendUseCase>(),
          gh<_i85.DeleteRecommendUseCase>(),
        ));
    gh.factory<_i101.SignUpBloc>(
        () => _i101.SignUpBloc(gh<_i61.SignUpEmailPasswordUseCase>()));
    gh.factory<_i102.ViewOrderBloc>(() => _i102.ViewOrderBloc(
          gh<_i74.CancelOrderUseCase>(),
          gh<_i96.OrderCompletedUseCase>(),
          gh<_i88.GetOrderByIDUseCase>(),
        ));
    gh.factory<_i103.AddProductBloc>(() => _i103.AddProductBloc(
          gh<_i79.CreateProductUseCase>(),
          gh<_i67.UpdateProductUseCase>(),
        ));
    gh.factory<_i104.AddProductCataloguesBloc>(
        () => _i104.AddProductCataloguesBloc(
              gh<_i78.CreateProductCataloguesUseCase>(),
              gh<_i66.UpdateProductCataloguesUseCase>(),
            ));
    gh.factory<_i105.AddRecommendBloc>(() => _i105.AddRecommendBloc(
          gh<_i80.CreateRecommendUseCase>(),
          gh<_i68.UpdateRecommendUseCase>(),
        ));
    gh.factory<_i106.ChangePasswordBloc>(
        () => _i106.ChangePasswordBloc(gh<_i75.ChangePasswordUseCase>()));
    gh.factory<_i107.ForgotPasswordBloc>(
        () => _i107.ForgotPasswordBloc(gh<_i86.ForgotPasswordUseCase>()));
    gh.factory<_i108.LoginBloc>(
        () => _i108.LoginBloc(gh<_i93.LoginEmailPasswordUseCase>()));
    return this;
  }
}

class _$InjectionModule extends _i109.InjectionModule {}
