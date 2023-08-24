// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:coffee_admin/injection.dart' as _i55;
import 'package:coffee_admin/src/data/local/dao/store_dao.dart' as _i8;
import 'package:coffee_admin/src/data/local/dao/user_dao.dart' as _i12;
import 'package:coffee_admin/src/data/local/database/coffee_database.dart'
    as _i4;
import 'package:coffee_admin/src/data/remote/api_service/api_service.dart'
    as _i3;
import 'package:coffee_admin/src/data/remote/firebase/firebase_service.dart'
    as _i6;
import 'package:coffee_admin/src/data/repositories/account_management_repository_impl.dart'
    as _i14;
import 'package:coffee_admin/src/data/repositories/coupon_repository_impl.dart'
    as _i16;
import 'package:coffee_admin/src/data/repositories/product_catalogues_repository_impl.dart'
    as _i26;
import 'package:coffee_admin/src/data/repositories/product_repository_impl.dart'
    as _i28;
import 'package:coffee_admin/src/data/repositories/recomment_repository_impl.dart'
    as _i30;
import 'package:coffee_admin/src/data/repositories/tag_repository_impl.dart'
    as _i10;
import 'package:coffee_admin/src/domain/repositories/account_management_repository.dart'
    as _i13;
import 'package:coffee_admin/src/domain/repositories/coupon_repository.dart'
    as _i15;
import 'package:coffee_admin/src/domain/repositories/product_catalogues_repository.dart'
    as _i25;
import 'package:coffee_admin/src/domain/repositories/product_repository.dart'
    as _i27;
import 'package:coffee_admin/src/domain/repositories/recommend_repository.dart'
    as _i29;
import 'package:coffee_admin/src/domain/repositories/tag_repository.dart'
    as _i9;
import 'package:coffee_admin/src/domain/use_cases/account_management_use_case/delete_account.dart'
    as _i19;
import 'package:coffee_admin/src/domain/use_cases/account_management_use_case/get_all_account.dart'
    as _i22;
import 'package:coffee_admin/src/domain/use_cases/coupon_use_case/create_coupon.dart'
    as _i17;
import 'package:coffee_admin/src/domain/use_cases/coupon_use_case/delete_coupon.dart'
    as _i20;
import 'package:coffee_admin/src/domain/use_cases/coupon_use_case/get_all_coupon.dart'
    as _i23;
import 'package:coffee_admin/src/domain/use_cases/coupon_use_case/update_coupon.dart'
    as _i32;
import 'package:coffee_admin/src/domain/use_cases/product_catalogues_use_case/create_product_catalogues.dart'
    as _i40;
import 'package:coffee_admin/src/domain/use_cases/product_catalogues_use_case/delete_product_catalogues.dart'
    as _i43;
import 'package:coffee_admin/src/domain/use_cases/product_catalogues_use_case/get_product_catalogues.dart'
    as _i46;
import 'package:coffee_admin/src/domain/use_cases/product_catalogues_use_case/update_product_catalogues.dart'
    as _i33;
import 'package:coffee_admin/src/domain/use_cases/product_use_case/create_product.dart'
    as _i41;
import 'package:coffee_admin/src/domain/use_cases/product_use_case/delete_product.dart'
    as _i44;
import 'package:coffee_admin/src/domain/use_cases/product_use_case/get_product.dart'
    as _i47;
import 'package:coffee_admin/src/domain/use_cases/product_use_case/update_product.dart'
    as _i34;
import 'package:coffee_admin/src/domain/use_cases/recommend_use_case/create_recommend.dart'
    as _i42;
import 'package:coffee_admin/src/domain/use_cases/recommend_use_case/delete_recommend.dart'
    as _i45;
import 'package:coffee_admin/src/domain/use_cases/recommend_use_case/get_recommend.dart'
    as _i48;
import 'package:coffee_admin/src/domain/use_cases/recommend_use_case/update_recommend.dart'
    as _i35;
import 'package:coffee_admin/src/domain/use_cases/tag_use_case/create_tag.dart'
    as _i18;
import 'package:coffee_admin/src/domain/use_cases/tag_use_case/delete_tag.dart'
    as _i21;
import 'package:coffee_admin/src/domain/use_cases/tag_use_case/get_tag.dart'
    as _i24;
import 'package:coffee_admin/src/domain/use_cases/tag_use_case/update_tag.dart'
    as _i11;
import 'package:coffee_admin/src/presentation/account_management/bloc/account_bloc.dart'
    as _i36;
import 'package:coffee_admin/src/presentation/add_coupon/bloc/add_coupon_bloc.dart'
    as _i37;
import 'package:coffee_admin/src/presentation/add_product/bloc/add_product_bloc.dart'
    as _i52;
import 'package:coffee_admin/src/presentation/add_product_catalogues/bloc/add_product_catalogues_bloc.dart'
    as _i53;
import 'package:coffee_admin/src/presentation/add_recommend/bloc/add_recommend_bloc.dart'
    as _i54;
import 'package:coffee_admin/src/presentation/add_tag/bloc/add_tag_bloc.dart'
    as _i38;
import 'package:coffee_admin/src/presentation/coupon/bloc/coupon_bloc.dart'
    as _i39;
import 'package:coffee_admin/src/presentation/product/bloc/product_bloc.dart'
    as _i49;
import 'package:coffee_admin/src/presentation/product_catalogues/bloc/product_catalogues_bloc.dart'
    as _i50;
import 'package:coffee_admin/src/presentation/recommend/bloc/recommend_bloc.dart'
    as _i51;
import 'package:coffee_admin/src/presentation/tag/bloc/tag_bloc.dart' as _i31;
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
    gh.lazySingleton<_i9.TagRepository>(() => _i10.TagRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i7.SharedPreferences>(),
        ));
    gh.lazySingleton<_i11.UpdateTagUseCase>(
        () => _i11.UpdateTagUseCase(gh<_i9.TagRepository>()));
    gh.lazySingleton<_i12.UserDao>(() => injectionModule.userDao);
    gh.lazySingleton<_i13.AccountManagementRepository>(
        () => _i14.AccountManagementRepositoryImpl(
              gh<_i3.ApiService>(),
              gh<_i7.SharedPreferences>(),
            ));
    gh.lazySingleton<_i15.CouponRepository>(() => _i16.CouponRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i7.SharedPreferences>(),
        ));
    gh.lazySingleton<_i17.CreateCouponUseCase>(
        () => _i17.CreateCouponUseCase(gh<_i15.CouponRepository>()));
    gh.lazySingleton<_i18.CreateTagUseCase>(
        () => _i18.CreateTagUseCase(gh<_i9.TagRepository>()));
    gh.lazySingleton<_i19.DeleteAccountUseCase>(() =>
        _i19.DeleteAccountUseCase(gh<_i13.AccountManagementRepository>()));
    gh.lazySingleton<_i20.DeleteCouponUseCase>(
        () => _i20.DeleteCouponUseCase(gh<_i15.CouponRepository>()));
    gh.lazySingleton<_i21.DeleteTagUseCase>(
        () => _i21.DeleteTagUseCase(gh<_i9.TagRepository>()));
    gh.lazySingleton<_i22.GetAllAccountUseCase>(() =>
        _i22.GetAllAccountUseCase(gh<_i13.AccountManagementRepository>()));
    gh.lazySingleton<_i23.GetAllCouponUseCase>(
        () => _i23.GetAllCouponUseCase(gh<_i15.CouponRepository>()));
    gh.lazySingleton<_i24.GetTagUseCase>(
        () => _i24.GetTagUseCase(gh<_i9.TagRepository>()));
    gh.lazySingleton<_i25.ProductCataloguesRepository>(
        () => _i26.ProductCataloguesRepositoryImpl(
              gh<_i3.ApiService>(),
              gh<_i7.SharedPreferences>(),
            ));
    gh.lazySingleton<_i27.ProductRepository>(() => _i28.ProductRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i7.SharedPreferences>(),
        ));
    gh.lazySingleton<_i29.RecommendRepository>(
        () => _i30.RecommendRepositoryImpl(
              gh<_i3.ApiService>(),
              gh<_i7.SharedPreferences>(),
            ));
    gh.factory<_i31.TagBloc>(() => _i31.TagBloc(
          gh<_i24.GetTagUseCase>(),
          gh<_i21.DeleteTagUseCase>(),
        ));
    gh.lazySingleton<_i32.UpdateCouponUseCase>(
        () => _i32.UpdateCouponUseCase(gh<_i15.CouponRepository>()));
    gh.lazySingleton<_i33.UpdateProductCataloguesUseCase>(() =>
        _i33.UpdateProductCataloguesUseCase(
            gh<_i25.ProductCataloguesRepository>()));
    gh.lazySingleton<_i34.UpdateProductUseCase>(
        () => _i34.UpdateProductUseCase(gh<_i27.ProductRepository>()));
    gh.lazySingleton<_i35.UpdateRecommendUseCase>(
        () => _i35.UpdateRecommendUseCase(gh<_i29.RecommendRepository>()));
    gh.factory<_i36.AccountBloc>(() => _i36.AccountBloc(
          gh<_i19.DeleteAccountUseCase>(),
          gh<_i22.GetAllAccountUseCase>(),
        ));
    gh.factory<_i37.AddCouponBloc>(() => _i37.AddCouponBloc(
          gh<_i17.CreateCouponUseCase>(),
          gh<_i32.UpdateCouponUseCase>(),
        ));
    gh.factory<_i38.AddTagBloc>(() => _i38.AddTagBloc(
          gh<_i18.CreateTagUseCase>(),
          gh<_i11.UpdateTagUseCase>(),
        ));
    gh.factory<_i39.CouponBloc>(() => _i39.CouponBloc(
          gh<_i23.GetAllCouponUseCase>(),
          gh<_i20.DeleteCouponUseCase>(),
        ));
    gh.lazySingleton<_i40.CreateProductCataloguesUseCase>(() =>
        _i40.CreateProductCataloguesUseCase(
            gh<_i25.ProductCataloguesRepository>()));
    gh.lazySingleton<_i41.CreateProductUseCase>(
        () => _i41.CreateProductUseCase(gh<_i27.ProductRepository>()));
    gh.lazySingleton<_i42.CreateRecommendUseCase>(
        () => _i42.CreateRecommendUseCase(gh<_i29.RecommendRepository>()));
    gh.lazySingleton<_i43.DeleteProductCataloguesUseCase>(() =>
        _i43.DeleteProductCataloguesUseCase(
            gh<_i25.ProductCataloguesRepository>()));
    gh.lazySingleton<_i44.DeleteProductUseCase>(
        () => _i44.DeleteProductUseCase(gh<_i27.ProductRepository>()));
    gh.lazySingleton<_i45.DeleteRecommendUseCase>(
        () => _i45.DeleteRecommendUseCase(gh<_i29.RecommendRepository>()));
    gh.lazySingleton<_i46.GetProductCataloguesUseCase>(() =>
        _i46.GetProductCataloguesUseCase(
            gh<_i25.ProductCataloguesRepository>()));
    gh.lazySingleton<_i47.GetProductUseCase>(
        () => _i47.GetProductUseCase(gh<_i27.ProductRepository>()));
    gh.lazySingleton<_i48.GetRecommendUseCase>(
        () => _i48.GetRecommendUseCase(gh<_i29.RecommendRepository>()));
    gh.factory<_i49.ProductBloc>(() => _i49.ProductBloc(
          gh<_i44.DeleteProductUseCase>(),
          gh<_i47.GetProductUseCase>(),
          gh<_i46.GetProductCataloguesUseCase>(),
        ));
    gh.factory<_i50.ProductCataloguesBloc>(() => _i50.ProductCataloguesBloc(
          gh<_i46.GetProductCataloguesUseCase>(),
          gh<_i43.DeleteProductCataloguesUseCase>(),
        ));
    gh.factory<_i51.RecommendBloc>(() => _i51.RecommendBloc(
          gh<_i48.GetRecommendUseCase>(),
          gh<_i45.DeleteRecommendUseCase>(),
        ));
    gh.factory<_i52.AddProductBloc>(() => _i52.AddProductBloc(
          gh<_i41.CreateProductUseCase>(),
          gh<_i34.UpdateProductUseCase>(),
        ));
    gh.factory<_i53.AddProductCataloguesBloc>(
        () => _i53.AddProductCataloguesBloc(
              gh<_i40.CreateProductCataloguesUseCase>(),
              gh<_i33.UpdateProductCataloguesUseCase>(),
            ));
    gh.factory<_i54.AddRecommendBloc>(() => _i54.AddRecommendBloc(
          gh<_i42.CreateRecommendUseCase>(),
          gh<_i35.UpdateRecommendUseCase>(),
        ));
    return this;
  }
}

class _$InjectionModule extends _i55.InjectionModule {}
