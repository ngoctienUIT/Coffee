// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:coffee_admin/injection.dart' as _i39;
import 'package:coffee_admin/src/data/local/dao/store_dao.dart' as _i8;
import 'package:coffee_admin/src/data/local/dao/user_dao.dart' as _i9;
import 'package:coffee_admin/src/data/local/database/coffee_database.dart'
    as _i4;
import 'package:coffee_admin/src/data/remote/api_service/api_service.dart'
    as _i3;
import 'package:coffee_admin/src/data/remote/firebase/firebase_service.dart'
    as _i6;
import 'package:coffee_admin/src/data/repositories/account_management_repository_impl.dart'
    as _i11;
import 'package:coffee_admin/src/data/repositories/coupon_repository_impl.dart'
    as _i13;
import 'package:coffee_admin/src/data/repositories/product_catalogues_repository_impl.dart'
    as _i20;
import 'package:coffee_admin/src/data/repositories/product_repository_impl.dart'
    as _i22;
import 'package:coffee_admin/src/domain/repositories/account_management_repository.dart'
    as _i10;
import 'package:coffee_admin/src/domain/repositories/coupon_repository.dart'
    as _i12;
import 'package:coffee_admin/src/domain/repositories/product_catalogues_repository.dart'
    as _i19;
import 'package:coffee_admin/src/domain/repositories/product_repository.dart'
    as _i21;
import 'package:coffee_admin/src/domain/use_cases/account_management_use_case/delete_account.dart'
    as _i15;
import 'package:coffee_admin/src/domain/use_cases/account_management_use_case/get_all_account.dart'
    as _i17;
import 'package:coffee_admin/src/domain/use_cases/coupon_use_case/create_coupon.dart'
    as _i14;
import 'package:coffee_admin/src/domain/use_cases/coupon_use_case/delete_coupon.dart'
    as _i16;
import 'package:coffee_admin/src/domain/use_cases/coupon_use_case/get_all_coupon.dart'
    as _i18;
import 'package:coffee_admin/src/domain/use_cases/coupon_use_case/update_coupon.dart'
    as _i23;
import 'package:coffee_admin/src/domain/use_cases/product_catalogues_use_case/create_product_catalogues.dart'
    as _i29;
import 'package:coffee_admin/src/domain/use_cases/product_catalogues_use_case/delete_product_catalogues.dart'
    as _i31;
import 'package:coffee_admin/src/domain/use_cases/product_catalogues_use_case/get_product_catalogues.dart'
    as _i33;
import 'package:coffee_admin/src/domain/use_cases/product_catalogues_use_case/update_product_catalogues.dart'
    as _i24;
import 'package:coffee_admin/src/domain/use_cases/product_use_case/create_product.dart'
    as _i30;
import 'package:coffee_admin/src/domain/use_cases/product_use_case/delete_product.dart'
    as _i32;
import 'package:coffee_admin/src/domain/use_cases/product_use_case/get_product.dart'
    as _i34;
import 'package:coffee_admin/src/domain/use_cases/product_use_case/update_product.dart'
    as _i25;
import 'package:coffee_admin/src/presentation/account_management/bloc/account_bloc.dart'
    as _i26;
import 'package:coffee_admin/src/presentation/add_coupon/bloc/add_coupon_bloc.dart'
    as _i27;
import 'package:coffee_admin/src/presentation/add_product/bloc/add_product_bloc.dart'
    as _i37;
import 'package:coffee_admin/src/presentation/add_product_catalogues/bloc/add_product_catalogues_bloc.dart'
    as _i38;
import 'package:coffee_admin/src/presentation/coupon/bloc/coupon_bloc.dart'
    as _i28;
import 'package:coffee_admin/src/presentation/product/bloc/product_bloc.dart'
    as _i35;
import 'package:coffee_admin/src/presentation/product_catalogues/bloc/product_catalogues_bloc.dart'
    as _i36;
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
    gh.lazySingleton<_i9.UserDao>(() => injectionModule.userDao);
    gh.lazySingleton<_i10.AccountManagementRepository>(
        () => _i11.AccountManagementRepositoryImpl(
              gh<_i3.ApiService>(),
              gh<_i7.SharedPreferences>(),
            ));
    gh.lazySingleton<_i12.CouponRepository>(() => _i13.CouponRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i7.SharedPreferences>(),
        ));
    gh.lazySingleton<_i14.CreateCouponUseCase>(
        () => _i14.CreateCouponUseCase(gh<_i12.CouponRepository>()));
    gh.lazySingleton<_i15.DeleteAccountUseCase>(() =>
        _i15.DeleteAccountUseCase(gh<_i10.AccountManagementRepository>()));
    gh.lazySingleton<_i16.DeleteCouponUseCase>(
        () => _i16.DeleteCouponUseCase(gh<_i12.CouponRepository>()));
    gh.lazySingleton<_i17.GetAllAccountUseCase>(() =>
        _i17.GetAllAccountUseCase(gh<_i10.AccountManagementRepository>()));
    gh.lazySingleton<_i18.GetAllCouponUseCase>(
        () => _i18.GetAllCouponUseCase(gh<_i12.CouponRepository>()));
    gh.lazySingleton<_i19.ProductCataloguesRepository>(
        () => _i20.ProductCataloguesRepositoryImpl(
              gh<_i3.ApiService>(),
              gh<_i7.SharedPreferences>(),
            ));
    gh.lazySingleton<_i21.ProductRepository>(() => _i22.ProductRepositoryImpl(
          gh<_i3.ApiService>(),
          gh<_i7.SharedPreferences>(),
        ));
    gh.lazySingleton<_i23.UpdateCouponUseCase>(
        () => _i23.UpdateCouponUseCase(gh<_i12.CouponRepository>()));
    gh.lazySingleton<_i24.UpdateProductCataloguesUseCase>(() =>
        _i24.UpdateProductCataloguesUseCase(
            gh<_i19.ProductCataloguesRepository>()));
    gh.lazySingleton<_i25.UpdateProductUseCase>(
        () => _i25.UpdateProductUseCase(gh<_i21.ProductRepository>()));
    gh.factory<_i26.AccountBloc>(() => _i26.AccountBloc(
          gh<_i15.DeleteAccountUseCase>(),
          gh<_i17.GetAllAccountUseCase>(),
        ));
    gh.factory<_i27.AddCouponBloc>(() => _i27.AddCouponBloc(
          gh<_i14.CreateCouponUseCase>(),
          gh<_i23.UpdateCouponUseCase>(),
        ));
    gh.factory<_i28.CouponBloc>(() => _i28.CouponBloc(
          gh<_i18.GetAllCouponUseCase>(),
          gh<_i16.DeleteCouponUseCase>(),
        ));
    gh.lazySingleton<_i29.CreateProductCataloguesUseCase>(() =>
        _i29.CreateProductCataloguesUseCase(
            gh<_i19.ProductCataloguesRepository>()));
    gh.lazySingleton<_i30.CreateProductUseCase>(
        () => _i30.CreateProductUseCase(gh<_i21.ProductRepository>()));
    gh.lazySingleton<_i31.DeleteProductCataloguesUseCase>(() =>
        _i31.DeleteProductCataloguesUseCase(
            gh<_i19.ProductCataloguesRepository>()));
    gh.lazySingleton<_i32.DeleteProductUseCase>(
        () => _i32.DeleteProductUseCase(gh<_i21.ProductRepository>()));
    gh.lazySingleton<_i33.GetProductCataloguesUseCase>(() =>
        _i33.GetProductCataloguesUseCase(
            gh<_i19.ProductCataloguesRepository>()));
    gh.lazySingleton<_i34.GetProductUseCase>(
        () => _i34.GetProductUseCase(gh<_i21.ProductRepository>()));
    gh.factory<_i35.ProductBloc>(() => _i35.ProductBloc(
          gh<_i32.DeleteProductUseCase>(),
          gh<_i34.GetProductUseCase>(),
          gh<_i33.GetProductCataloguesUseCase>(),
        ));
    gh.factory<_i36.ProductCataloguesBloc>(() => _i36.ProductCataloguesBloc(
          gh<_i33.GetProductCataloguesUseCase>(),
          gh<_i31.DeleteProductCataloguesUseCase>(),
        ));
    gh.factory<_i37.AddProductBloc>(() => _i37.AddProductBloc(
          gh<_i30.CreateProductUseCase>(),
          gh<_i25.UpdateProductUseCase>(),
        ));
    gh.factory<_i38.AddProductCataloguesBloc>(
        () => _i38.AddProductCataloguesBloc(
              gh<_i29.CreateProductCataloguesUseCase>(),
              gh<_i24.UpdateProductCataloguesUseCase>(),
            ));
    return this;
  }
}

class _$InjectionModule extends _i39.InjectionModule {}
