// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:coffee_admin/injection.dart' as _i92;
import 'package:coffee_admin/src/data/local/dao/store_dao.dart' as _i8;
import 'package:coffee_admin/src/data/local/dao/user_dao.dart' as _i18;
import 'package:coffee_admin/src/data/local/database/coffee_database.dart'
    as _i4;
import 'package:coffee_admin/src/data/remote/api_service/api_service.dart'
    as _i3;
import 'package:coffee_admin/src/data/remote/firebase/firebase_service.dart'
    as _i6;
import 'package:coffee_admin/src/data/repositories/account_management_repository_impl.dart'
    as _i20;
import 'package:coffee_admin/src/data/repositories/coupon_repository_impl.dart'
    as _i22;
import 'package:coffee_admin/src/data/repositories/login_repository_impl.dart'
    as _i39;
import 'package:coffee_admin/src/data/repositories/order_repository_impl.dart'
    as _i41;
import 'package:coffee_admin/src/data/repositories/password_repository_impl.dart'
    as _i43;
import 'package:coffee_admin/src/data/repositories/product_catalogues_repository_impl.dart'
    as _i45;
import 'package:coffee_admin/src/data/repositories/product_repository_impl.dart'
    as _i47;
import 'package:coffee_admin/src/data/repositories/recomment_repository_impl.dart'
    as _i49;
import 'package:coffee_admin/src/data/repositories/store_repository_impl.dart'
    as _i10;
import 'package:coffee_admin/src/data/repositories/tag_repository_impl.dart'
    as _i12;
import 'package:coffee_admin/src/data/repositories/topping_repository_impl.dart'
    as _i14;
import 'package:coffee_admin/src/domain/repositories/account_management_repository.dart'
    as _i19;
import 'package:coffee_admin/src/domain/repositories/coupon_repository.dart'
    as _i21;
import 'package:coffee_admin/src/domain/repositories/login_repository.dart'
    as _i38;
import 'package:coffee_admin/src/domain/repositories/order_repository.dart'
    as _i40;
import 'package:coffee_admin/src/domain/repositories/password_repository.dart'
    as _i42;
import 'package:coffee_admin/src/domain/repositories/product_catalogues_repository.dart'
    as _i44;
import 'package:coffee_admin/src/domain/repositories/product_repository.dart'
    as _i46;
import 'package:coffee_admin/src/domain/repositories/recommend_repository.dart'
    as _i48;
import 'package:coffee_admin/src/domain/repositories/store_repository.dart'
    as _i9;
import 'package:coffee_admin/src/domain/repositories/tag_repository.dart'
    as _i11;
import 'package:coffee_admin/src/domain/repositories/topping_repository.dart'
    as _i13;
import 'package:coffee_admin/src/domain/use_cases/account_management_use_case/delete_account.dart'
    as _i27;
import 'package:coffee_admin/src/domain/use_cases/account_management_use_case/get_all_account.dart'
    as _i33;
import 'package:coffee_admin/src/domain/use_cases/coupon_use_case/create_coupon.dart'
    as _i23;
import 'package:coffee_admin/src/domain/use_cases/coupon_use_case/delete_coupon.dart'
    as _i28;
import 'package:coffee_admin/src/domain/use_cases/coupon_use_case/get_all_coupon.dart'
    as _i34;
import 'package:coffee_admin/src/domain/use_cases/coupon_use_case/update_coupon.dart'
    as _i53;
import 'package:coffee_admin/src/domain/use_cases/login/login_email_password.dart'
    as _i79;
import 'package:coffee_admin/src/domain/use_cases/order_use_case/cancel_order.dart'
    as _i62;
import 'package:coffee_admin/src/domain/use_cases/order_use_case/get_list_order.dart'
    as _i73;
import 'package:coffee_admin/src/domain/use_cases/order_use_case/get_order_by_id.dart'
    as _i74;
import 'package:coffee_admin/src/domain/use_cases/order_use_case/order_completed.dart'
    as _i82;
import 'package:coffee_admin/src/domain/use_cases/password_use_case/change_password.dart'
    as _i63;
import 'package:coffee_admin/src/domain/use_cases/password_use_case/create_new_password.dart'
    as _i65;
import 'package:coffee_admin/src/domain/use_cases/password_use_case/forgot_password.dart'
    as _i72;
import 'package:coffee_admin/src/domain/use_cases/password_use_case/input_pin.dart'
    as _i78;
import 'package:coffee_admin/src/domain/use_cases/product_catalogues_use_case/create_product_catalogues.dart'
    as _i66;
import 'package:coffee_admin/src/domain/use_cases/product_catalogues_use_case/delete_product_catalogues.dart'
    as _i69;
import 'package:coffee_admin/src/domain/use_cases/product_catalogues_use_case/get_product_catalogues.dart'
    as _i75;
import 'package:coffee_admin/src/domain/use_cases/product_catalogues_use_case/update_product_catalogues.dart'
    as _i54;
import 'package:coffee_admin/src/domain/use_cases/product_use_case/create_product.dart'
    as _i67;
import 'package:coffee_admin/src/domain/use_cases/product_use_case/delete_product.dart'
    as _i70;
import 'package:coffee_admin/src/domain/use_cases/product_use_case/get_product.dart'
    as _i76;
import 'package:coffee_admin/src/domain/use_cases/product_use_case/update_product.dart'
    as _i55;
import 'package:coffee_admin/src/domain/use_cases/recommend_use_case/create_recommend.dart'
    as _i68;
import 'package:coffee_admin/src/domain/use_cases/recommend_use_case/delete_recommend.dart'
    as _i71;
import 'package:coffee_admin/src/domain/use_cases/recommend_use_case/get_recommend.dart'
    as _i77;
import 'package:coffee_admin/src/domain/use_cases/recommend_use_case/update_recommend.dart'
    as _i56;
import 'package:coffee_admin/src/domain/use_cases/store_use_case/create_store.dart'
    as _i24;
import 'package:coffee_admin/src/domain/use_cases/store_use_case/delete_store.dart'
    as _i29;
import 'package:coffee_admin/src/domain/use_cases/store_use_case/fetch_store.dart'
    as _i32;
import 'package:coffee_admin/src/domain/use_cases/store_use_case/get_store.dart'
    as _i35;
import 'package:coffee_admin/src/domain/use_cases/store_use_case/update_store.dart'
    as _i15;
import 'package:coffee_admin/src/domain/use_cases/tag_use_case/create_tag.dart'
    as _i25;
import 'package:coffee_admin/src/domain/use_cases/tag_use_case/delete_tag.dart'
    as _i30;
import 'package:coffee_admin/src/domain/use_cases/tag_use_case/get_tag.dart'
    as _i36;
import 'package:coffee_admin/src/domain/use_cases/tag_use_case/update_tag.dart'
    as _i16;
import 'package:coffee_admin/src/domain/use_cases/topping_use_case/create_topping.dart'
    as _i26;
import 'package:coffee_admin/src/domain/use_cases/topping_use_case/delete_topping.dart'
    as _i31;
import 'package:coffee_admin/src/domain/use_cases/topping_use_case/get_topping.dart'
    as _i37;
import 'package:coffee_admin/src/domain/use_cases/topping_use_case/update_topping.dart'
    as _i17;
import 'package:coffee_admin/src/presentation/account_management/bloc/account_bloc.dart'
    as _i57;
import 'package:coffee_admin/src/presentation/add_coupon/bloc/add_coupon_bloc.dart'
    as _i58;
import 'package:coffee_admin/src/presentation/add_product/bloc/add_product_bloc.dart'
    as _i87;
import 'package:coffee_admin/src/presentation/add_product_catalogues/bloc/add_product_catalogues_bloc.dart'
    as _i88;
import 'package:coffee_admin/src/presentation/add_recommend/bloc/add_recommend_bloc.dart'
    as _i89;
import 'package:coffee_admin/src/presentation/add_store/bloc/add_store_bloc.dart'
    as _i59;
import 'package:coffee_admin/src/presentation/add_tag/bloc/add_tag_bloc.dart'
    as _i60;
import 'package:coffee_admin/src/presentation/add_topping/bloc/add_topping_bloc.dart'
    as _i61;
import 'package:coffee_admin/src/presentation/change_password/bloc/change_password_bloc.dart'
    as _i90;
import 'package:coffee_admin/src/presentation/coupon/bloc/coupon_bloc.dart'
    as _i64;
import 'package:coffee_admin/src/presentation/forgot_password/bloc/forgot_password_bloc.dart'
    as _i91;
import 'package:coffee_admin/src/presentation/new_password/bloc/new_password_bloc.dart'
    as _i80;
import 'package:coffee_admin/src/presentation/order/bloc/order_bloc.dart'
    as _i81;
import 'package:coffee_admin/src/presentation/product/bloc/product_bloc.dart'
    as _i83;
import 'package:coffee_admin/src/presentation/product_catalogues/bloc/product_catalogues_bloc.dart'
    as _i84;
import 'package:coffee_admin/src/presentation/recommend/bloc/recommend_bloc.dart'
    as _i85;
import 'package:coffee_admin/src/presentation/store/bloc/store_bloc.dart'
    as _i50;
import 'package:coffee_admin/src/presentation/tag/bloc/tag_bloc.dart' as _i51;
import 'package:coffee_admin/src/presentation/topping/bloc/topping_bloc.dart'
    as _i52;
import 'package:coffee_admin/src/presentation/view_order/bloc/view_order_bloc.dart'
    as _i86;
import 'package:dio/dio.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i7;

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
    await gh.lazySingletonAsync<_i7.SharedPreferences>(
      () => injectionModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i8.StoreDao>(() => injectionModule.storeDao);
    gh.lazySingleton<_i9.StoreRepository>(() => _i10.StoreRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i7.SharedPreferences>(),
          gh<_i8.StoreDao>(),
        ));
    gh.lazySingleton<_i11.TagRepository>(() => _i12.TagRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i7.SharedPreferences>(),
        ));
    gh.lazySingleton<_i13.ToppingRepository>(() => _i14.ToppingRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i7.SharedPreferences>(),
        ));
    gh.lazySingleton<_i15.UpdateStoreUseCase>(
        () => _i15.UpdateStoreUseCase(gh<_i9.StoreRepository>()));
    gh.lazySingleton<_i16.UpdateTagUseCase>(
        () => _i16.UpdateTagUseCase(gh<_i11.TagRepository>()));
    gh.lazySingleton<_i17.UpdateToppingUseCase>(
        () => _i17.UpdateToppingUseCase(gh<_i13.ToppingRepository>()));
    gh.lazySingleton<_i18.UserDao>(() => injectionModule.userDao);
    gh.lazySingleton<_i19.AccountManagementRepository>(
        () => _i20.AccountManagementRepositoryImpl(
              gh<_i3.ApiService>(),
              gh<_i7.SharedPreferences>(),
            ));
    gh.lazySingleton<_i21.CouponRepository>(() => _i22.CouponRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i7.SharedPreferences>(),
        ));
    gh.lazySingleton<_i23.CreateCouponUseCase>(
        () => _i23.CreateCouponUseCase(gh<_i21.CouponRepository>()));
    gh.lazySingleton<_i24.CreateStoreUseCase>(
        () => _i24.CreateStoreUseCase(gh<_i9.StoreRepository>()));
    gh.lazySingleton<_i25.CreateTagUseCase>(
        () => _i25.CreateTagUseCase(gh<_i11.TagRepository>()));
    gh.lazySingleton<_i26.CreateToppingUseCase>(
        () => _i26.CreateToppingUseCase(gh<_i13.ToppingRepository>()));
    gh.lazySingleton<_i27.DeleteAccountUseCase>(() =>
        _i27.DeleteAccountUseCase(gh<_i19.AccountManagementRepository>()));
    gh.lazySingleton<_i28.DeleteCouponUseCase>(
        () => _i28.DeleteCouponUseCase(gh<_i21.CouponRepository>()));
    gh.lazySingleton<_i29.DeleteStoreUseCase>(
        () => _i29.DeleteStoreUseCase(gh<_i9.StoreRepository>()));
    gh.lazySingleton<_i30.DeleteTagUseCase>(
        () => _i30.DeleteTagUseCase(gh<_i11.TagRepository>()));
    gh.lazySingleton<_i31.DeleteToppingUseCase>(
        () => _i31.DeleteToppingUseCase(gh<_i13.ToppingRepository>()));
    gh.lazySingleton<_i32.FetchStoreUseCase>(
        () => _i32.FetchStoreUseCase(gh<_i9.StoreRepository>()));
    gh.lazySingleton<_i33.GetAllAccountUseCase>(() =>
        _i33.GetAllAccountUseCase(gh<_i19.AccountManagementRepository>()));
    gh.lazySingleton<_i34.GetAllCouponUseCase>(
        () => _i34.GetAllCouponUseCase(gh<_i21.CouponRepository>()));
    gh.lazySingleton<_i35.GetStoreUseCase>(
        () => _i35.GetStoreUseCase(gh<_i9.StoreRepository>()));
    gh.lazySingleton<_i36.GetTagUseCase>(
        () => _i36.GetTagUseCase(gh<_i11.TagRepository>()));
    gh.lazySingleton<_i37.GetToppingUseCase>(
        () => _i37.GetToppingUseCase(gh<_i13.ToppingRepository>()));
    gh.lazySingleton<_i38.LoginRepository>(() => _i39.LoginRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i7.SharedPreferences>(),
        ));
    gh.lazySingleton<_i40.OrderRepository>(() => _i41.OrderRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i7.SharedPreferences>(),
          gh<_i18.UserDao>(),
        ));
    gh.lazySingleton<_i42.PasswordRepository>(() => _i43.PasswordRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i7.SharedPreferences>(),
        ));
    gh.lazySingleton<_i44.ProductCataloguesRepository>(
        () => _i45.ProductCataloguesRepositoryImpl(
              gh<_i3.ApiService>(),
              gh<_i7.SharedPreferences>(),
            ));
    gh.lazySingleton<_i46.ProductRepository>(() => _i47.ProductRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i7.SharedPreferences>(),
        ));
    gh.lazySingleton<_i48.RecommendRepository>(
        () => _i49.RecommendRepositoryImpl(
              gh<_i3.ApiService>(),
              gh<_i7.SharedPreferences>(),
            ));
    gh.factory<_i50.StoreBloc>(() => _i50.StoreBloc(
          gh<_i29.DeleteStoreUseCase>(),
          gh<_i35.GetStoreUseCase>(),
        ));
    gh.factory<_i51.TagBloc>(() => _i51.TagBloc(
          gh<_i36.GetTagUseCase>(),
          gh<_i30.DeleteTagUseCase>(),
        ));
    gh.factory<_i52.ToppingBloc>(() => _i52.ToppingBloc(
          gh<_i37.GetToppingUseCase>(),
          gh<_i31.DeleteToppingUseCase>(),
        ));
    gh.lazySingleton<_i53.UpdateCouponUseCase>(
        () => _i53.UpdateCouponUseCase(gh<_i21.CouponRepository>()));
    gh.lazySingleton<_i54.UpdateProductCataloguesUseCase>(() =>
        _i54.UpdateProductCataloguesUseCase(
            gh<_i44.ProductCataloguesRepository>()));
    gh.lazySingleton<_i55.UpdateProductUseCase>(
        () => _i55.UpdateProductUseCase(gh<_i46.ProductRepository>()));
    gh.lazySingleton<_i56.UpdateRecommendUseCase>(
        () => _i56.UpdateRecommendUseCase(gh<_i48.RecommendRepository>()));
    gh.factory<_i57.AccountBloc>(() => _i57.AccountBloc(
          gh<_i27.DeleteAccountUseCase>(),
          gh<_i33.GetAllAccountUseCase>(),
        ));
    gh.factory<_i58.AddCouponBloc>(() => _i58.AddCouponBloc(
          gh<_i23.CreateCouponUseCase>(),
          gh<_i53.UpdateCouponUseCase>(),
        ));
    gh.factory<_i59.AddStoreBloc>(() => _i59.AddStoreBloc(
          gh<_i24.CreateStoreUseCase>(),
          gh<_i15.UpdateStoreUseCase>(),
        ));
    gh.factory<_i60.AddTagBloc>(() => _i60.AddTagBloc(
          gh<_i25.CreateTagUseCase>(),
          gh<_i16.UpdateTagUseCase>(),
        ));
    gh.factory<_i61.AddToppingBloc>(() => _i61.AddToppingBloc(
          gh<_i26.CreateToppingUseCase>(),
          gh<_i17.UpdateToppingUseCase>(),
        ));
    gh.lazySingleton<_i62.CancelOrderUseCase>(
        () => _i62.CancelOrderUseCase(gh<_i40.OrderRepository>()));
    gh.lazySingleton<_i63.ChangePasswordUseCase>(
        () => _i63.ChangePasswordUseCase(gh<_i42.PasswordRepository>()));
    gh.factory<_i64.CouponBloc>(() => _i64.CouponBloc(
          gh<_i34.GetAllCouponUseCase>(),
          gh<_i28.DeleteCouponUseCase>(),
        ));
    gh.lazySingleton<_i65.CreateNewPasswordUseCase>(
        () => _i65.CreateNewPasswordUseCase(gh<_i42.PasswordRepository>()));
    gh.lazySingleton<_i66.CreateProductCataloguesUseCase>(() =>
        _i66.CreateProductCataloguesUseCase(
            gh<_i44.ProductCataloguesRepository>()));
    gh.lazySingleton<_i67.CreateProductUseCase>(
        () => _i67.CreateProductUseCase(gh<_i46.ProductRepository>()));
    gh.lazySingleton<_i68.CreateRecommendUseCase>(
        () => _i68.CreateRecommendUseCase(gh<_i48.RecommendRepository>()));
    gh.lazySingleton<_i69.DeleteProductCataloguesUseCase>(() =>
        _i69.DeleteProductCataloguesUseCase(
            gh<_i44.ProductCataloguesRepository>()));
    gh.lazySingleton<_i70.DeleteProductUseCase>(
        () => _i70.DeleteProductUseCase(gh<_i46.ProductRepository>()));
    gh.lazySingleton<_i71.DeleteRecommendUseCase>(
        () => _i71.DeleteRecommendUseCase(gh<_i48.RecommendRepository>()));
    gh.lazySingleton<_i72.ForgotPasswordUseCase>(
        () => _i72.ForgotPasswordUseCase(gh<_i42.PasswordRepository>()));
    gh.lazySingleton<_i73.GetListOrderUseCase>(
        () => _i73.GetListOrderUseCase(gh<_i40.OrderRepository>()));
    gh.lazySingleton<_i74.GetOrderByIDUseCase>(
        () => _i74.GetOrderByIDUseCase(gh<_i40.OrderRepository>()));
    gh.lazySingleton<_i75.GetProductCataloguesUseCase>(() =>
        _i75.GetProductCataloguesUseCase(
            gh<_i44.ProductCataloguesRepository>()));
    gh.lazySingleton<_i76.GetProductUseCase>(
        () => _i76.GetProductUseCase(gh<_i46.ProductRepository>()));
    gh.lazySingleton<_i77.GetRecommendUseCase>(
        () => _i77.GetRecommendUseCase(gh<_i48.RecommendRepository>()));
    gh.lazySingleton<_i78.InputPinUseCase>(
        () => _i78.InputPinUseCase(gh<_i42.PasswordRepository>()));
    gh.lazySingleton<_i79.LoginEmailPasswordUseCase>(
        () => _i79.LoginEmailPasswordUseCase(gh<_i38.LoginRepository>()));
    gh.factory<_i80.NewPasswordBloc>(
        () => _i80.NewPasswordBloc(gh<_i65.CreateNewPasswordUseCase>()));
    gh.factory<_i81.OrderBloc>(
        () => _i81.OrderBloc(gh<_i73.GetListOrderUseCase>()));
    gh.lazySingleton<_i82.OrderCompletedUseCase>(
        () => _i82.OrderCompletedUseCase(gh<_i40.OrderRepository>()));
    gh.factory<_i83.ProductBloc>(() => _i83.ProductBloc(
          gh<_i70.DeleteProductUseCase>(),
          gh<_i76.GetProductUseCase>(),
          gh<_i75.GetProductCataloguesUseCase>(),
        ));
    gh.factory<_i84.ProductCataloguesBloc>(() => _i84.ProductCataloguesBloc(
          gh<_i75.GetProductCataloguesUseCase>(),
          gh<_i69.DeleteProductCataloguesUseCase>(),
        ));
    gh.factory<_i85.RecommendBloc>(() => _i85.RecommendBloc(
          gh<_i77.GetRecommendUseCase>(),
          gh<_i71.DeleteRecommendUseCase>(),
        ));
    gh.factory<_i86.ViewOrderBloc>(() => _i86.ViewOrderBloc(
          gh<_i62.CancelOrderUseCase>(),
          gh<_i82.OrderCompletedUseCase>(),
          gh<_i74.GetOrderByIDUseCase>(),
        ));
    gh.factory<_i87.AddProductBloc>(() => _i87.AddProductBloc(
          gh<_i67.CreateProductUseCase>(),
          gh<_i55.UpdateProductUseCase>(),
        ));
    gh.factory<_i88.AddProductCataloguesBloc>(
        () => _i88.AddProductCataloguesBloc(
              gh<_i66.CreateProductCataloguesUseCase>(),
              gh<_i54.UpdateProductCataloguesUseCase>(),
            ));
    gh.factory<_i89.AddRecommendBloc>(() => _i89.AddRecommendBloc(
          gh<_i68.CreateRecommendUseCase>(),
          gh<_i56.UpdateRecommendUseCase>(),
        ));
    gh.factory<_i90.ChangePasswordBloc>(
        () => _i90.ChangePasswordBloc(gh<_i63.ChangePasswordUseCase>()));
    gh.factory<_i91.ForgotPasswordBloc>(
        () => _i91.ForgotPasswordBloc(gh<_i72.ForgotPasswordUseCase>()));
    return this;
  }
}

class _$InjectionModule extends _i92.InjectionModule {}
