// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:coffee_admin/injection.dart' as _i72;
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
import 'package:coffee_admin/src/data/repositories/product_catalogues_repository_impl.dart'
    as _i39;
import 'package:coffee_admin/src/data/repositories/product_repository_impl.dart'
    as _i41;
import 'package:coffee_admin/src/data/repositories/recomment_repository_impl.dart'
    as _i43;
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
import 'package:coffee_admin/src/domain/repositories/product_catalogues_repository.dart'
    as _i38;
import 'package:coffee_admin/src/domain/repositories/product_repository.dart'
    as _i40;
import 'package:coffee_admin/src/domain/repositories/recommend_repository.dart'
    as _i42;
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
    as _i47;
import 'package:coffee_admin/src/domain/use_cases/product_catalogues_use_case/create_product_catalogues.dart'
    as _i57;
import 'package:coffee_admin/src/domain/use_cases/product_catalogues_use_case/delete_product_catalogues.dart'
    as _i60;
import 'package:coffee_admin/src/domain/use_cases/product_catalogues_use_case/get_product_catalogues.dart'
    as _i63;
import 'package:coffee_admin/src/domain/use_cases/product_catalogues_use_case/update_product_catalogues.dart'
    as _i48;
import 'package:coffee_admin/src/domain/use_cases/product_use_case/create_product.dart'
    as _i58;
import 'package:coffee_admin/src/domain/use_cases/product_use_case/delete_product.dart'
    as _i61;
import 'package:coffee_admin/src/domain/use_cases/product_use_case/get_product.dart'
    as _i64;
import 'package:coffee_admin/src/domain/use_cases/product_use_case/update_product.dart'
    as _i49;
import 'package:coffee_admin/src/domain/use_cases/recommend_use_case/create_recommend.dart'
    as _i59;
import 'package:coffee_admin/src/domain/use_cases/recommend_use_case/delete_recommend.dart'
    as _i62;
import 'package:coffee_admin/src/domain/use_cases/recommend_use_case/get_recommend.dart'
    as _i65;
import 'package:coffee_admin/src/domain/use_cases/recommend_use_case/update_recommend.dart'
    as _i50;
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
    as _i51;
import 'package:coffee_admin/src/presentation/add_coupon/bloc/add_coupon_bloc.dart'
    as _i52;
import 'package:coffee_admin/src/presentation/add_product/bloc/add_product_bloc.dart'
    as _i69;
import 'package:coffee_admin/src/presentation/add_product_catalogues/bloc/add_product_catalogues_bloc.dart'
    as _i70;
import 'package:coffee_admin/src/presentation/add_recommend/bloc/add_recommend_bloc.dart'
    as _i71;
import 'package:coffee_admin/src/presentation/add_store/bloc/add_store_bloc.dart'
    as _i53;
import 'package:coffee_admin/src/presentation/add_tag/bloc/add_tag_bloc.dart'
    as _i54;
import 'package:coffee_admin/src/presentation/add_topping/bloc/add_topping_bloc.dart'
    as _i55;
import 'package:coffee_admin/src/presentation/coupon/bloc/coupon_bloc.dart'
    as _i56;
import 'package:coffee_admin/src/presentation/product/bloc/product_bloc.dart'
    as _i66;
import 'package:coffee_admin/src/presentation/product_catalogues/bloc/product_catalogues_bloc.dart'
    as _i67;
import 'package:coffee_admin/src/presentation/recommend/bloc/recommend_bloc.dart'
    as _i68;
import 'package:coffee_admin/src/presentation/store/bloc/store_bloc.dart'
    as _i44;
import 'package:coffee_admin/src/presentation/tag/bloc/tag_bloc.dart' as _i45;
import 'package:coffee_admin/src/presentation/topping/bloc/topping_bloc.dart'
    as _i46;
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
    gh.lazySingleton<_i38.ProductCataloguesRepository>(
        () => _i39.ProductCataloguesRepositoryImpl(
              gh<_i3.ApiService>(),
              gh<_i7.SharedPreferences>(),
            ));
    gh.lazySingleton<_i40.ProductRepository>(() => _i41.ProductRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i7.SharedPreferences>(),
        ));
    gh.lazySingleton<_i42.RecommendRepository>(
        () => _i43.RecommendRepositoryImpl(
              gh<_i3.ApiService>(),
              gh<_i7.SharedPreferences>(),
            ));
    gh.factory<_i44.StoreBloc>(() => _i44.StoreBloc(
          gh<_i29.DeleteStoreUseCase>(),
          gh<_i35.GetStoreUseCase>(),
        ));
    gh.factory<_i45.TagBloc>(() => _i45.TagBloc(
          gh<_i36.GetTagUseCase>(),
          gh<_i30.DeleteTagUseCase>(),
        ));
    gh.factory<_i46.ToppingBloc>(() => _i46.ToppingBloc(
          gh<_i37.GetToppingUseCase>(),
          gh<_i31.DeleteToppingUseCase>(),
        ));
    gh.lazySingleton<_i47.UpdateCouponUseCase>(
        () => _i47.UpdateCouponUseCase(gh<_i21.CouponRepository>()));
    gh.lazySingleton<_i48.UpdateProductCataloguesUseCase>(() =>
        _i48.UpdateProductCataloguesUseCase(
            gh<_i38.ProductCataloguesRepository>()));
    gh.lazySingleton<_i49.UpdateProductUseCase>(
        () => _i49.UpdateProductUseCase(gh<_i40.ProductRepository>()));
    gh.lazySingleton<_i50.UpdateRecommendUseCase>(
        () => _i50.UpdateRecommendUseCase(gh<_i42.RecommendRepository>()));
    gh.factory<_i51.AccountBloc>(() => _i51.AccountBloc(
          gh<_i27.DeleteAccountUseCase>(),
          gh<_i33.GetAllAccountUseCase>(),
        ));
    gh.factory<_i52.AddCouponBloc>(() => _i52.AddCouponBloc(
          gh<_i23.CreateCouponUseCase>(),
          gh<_i47.UpdateCouponUseCase>(),
        ));
    gh.factory<_i53.AddStoreBloc>(() => _i53.AddStoreBloc(
          gh<_i24.CreateStoreUseCase>(),
          gh<_i15.UpdateStoreUseCase>(),
        ));
    gh.factory<_i54.AddTagBloc>(() => _i54.AddTagBloc(
          gh<_i25.CreateTagUseCase>(),
          gh<_i16.UpdateTagUseCase>(),
        ));
    gh.factory<_i55.AddToppingBloc>(() => _i55.AddToppingBloc(
          gh<_i26.CreateToppingUseCase>(),
          gh<_i17.UpdateToppingUseCase>(),
        ));
    gh.factory<_i56.CouponBloc>(() => _i56.CouponBloc(
          gh<_i34.GetAllCouponUseCase>(),
          gh<_i28.DeleteCouponUseCase>(),
        ));
    gh.lazySingleton<_i57.CreateProductCataloguesUseCase>(() =>
        _i57.CreateProductCataloguesUseCase(
            gh<_i38.ProductCataloguesRepository>()));
    gh.lazySingleton<_i58.CreateProductUseCase>(
        () => _i58.CreateProductUseCase(gh<_i40.ProductRepository>()));
    gh.lazySingleton<_i59.CreateRecommendUseCase>(
        () => _i59.CreateRecommendUseCase(gh<_i42.RecommendRepository>()));
    gh.lazySingleton<_i60.DeleteProductCataloguesUseCase>(() =>
        _i60.DeleteProductCataloguesUseCase(
            gh<_i38.ProductCataloguesRepository>()));
    gh.lazySingleton<_i61.DeleteProductUseCase>(
        () => _i61.DeleteProductUseCase(gh<_i40.ProductRepository>()));
    gh.lazySingleton<_i62.DeleteRecommendUseCase>(
        () => _i62.DeleteRecommendUseCase(gh<_i42.RecommendRepository>()));
    gh.lazySingleton<_i63.GetProductCataloguesUseCase>(() =>
        _i63.GetProductCataloguesUseCase(
            gh<_i38.ProductCataloguesRepository>()));
    gh.lazySingleton<_i64.GetProductUseCase>(
        () => _i64.GetProductUseCase(gh<_i40.ProductRepository>()));
    gh.lazySingleton<_i65.GetRecommendUseCase>(
        () => _i65.GetRecommendUseCase(gh<_i42.RecommendRepository>()));
    gh.factory<_i66.ProductBloc>(() => _i66.ProductBloc(
          gh<_i61.DeleteProductUseCase>(),
          gh<_i64.GetProductUseCase>(),
          gh<_i63.GetProductCataloguesUseCase>(),
        ));
    gh.factory<_i67.ProductCataloguesBloc>(() => _i67.ProductCataloguesBloc(
          gh<_i63.GetProductCataloguesUseCase>(),
          gh<_i60.DeleteProductCataloguesUseCase>(),
        ));
    gh.factory<_i68.RecommendBloc>(() => _i68.RecommendBloc(
          gh<_i65.GetRecommendUseCase>(),
          gh<_i62.DeleteRecommendUseCase>(),
        ));
    gh.factory<_i69.AddProductBloc>(() => _i69.AddProductBloc(
          gh<_i58.CreateProductUseCase>(),
          gh<_i49.UpdateProductUseCase>(),
        ));
    gh.factory<_i70.AddProductCataloguesBloc>(
        () => _i70.AddProductCataloguesBloc(
              gh<_i57.CreateProductCataloguesUseCase>(),
              gh<_i48.UpdateProductCataloguesUseCase>(),
            ));
    gh.factory<_i71.AddRecommendBloc>(() => _i71.AddRecommendBloc(
          gh<_i59.CreateRecommendUseCase>(),
          gh<_i50.UpdateRecommendUseCase>(),
        ));
    return this;
  }
}

class _$InjectionModule extends _i72.InjectionModule {}
