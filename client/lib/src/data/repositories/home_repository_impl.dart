import 'package:coffee/injection.dart';
import 'package:coffee/src/core/resources/data_state.dart';
import 'package:coffee/src/core/resources/request_state.dart';

import 'package:coffee/src/core/response/home_response/recommend_response.dart';
import 'package:coffee/src/core/utils/extensions/dio_extension.dart';
import 'package:coffee/src/core/utils/extensions/list_extension.dart';
import 'package:coffee/src/data/remote/api_service/api_service.dart';
import 'package:coffee/src/data/remote/response/coupon/coupon_response.dart';
import 'package:coffee/src/data/remote/response/order/order_response.dart';
import 'package:coffee/src/data/remote/response/product/product_response.dart';
import 'package:coffee/src/data/remote/response/weather/weather_response.dart';
import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart' as inject;
import 'package:retrofit/retrofit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/home_repository.dart';
import '../local/dao/store_dao.dart';
import '../models/order.dart';
import '../models/store.dart';
import '../models/user.dart';

@inject.LazySingleton(as: HomeRepository)
class HomeRepositoryImpl extends HomeRepository {
  HomeRepositoryImpl(this._apiService, this._prefs, this._storeDao);

  final ApiService _apiService;
  final SharedPreferences _prefs;
  final StoreDao _storeDao;

  @override
  Future<DataState<List<CouponResponse>>> getCoupon() async {
    try {
      registerStore();
      final listCoupon = await _apiService.getAllCoupons();
      return DataSuccess(listCoupon.data.filterCoupon());
    } on DioException catch (e) {
      String error = e.getError();
      print(error);
      return DataFailed(error);
    } catch (e) {
      print(e);
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<OrderResponse?>> getOrderSpending() async {
    try {
      final token = _prefs.getString("token") ?? "";
      final user = getIt<User>();
      final response = await _apiService.getAllOrders(
          "Bearer $token", user.username, "PENDING");
      OrderResponse? myOrder = response.data.isEmpty ? null : response.data[0];
      return DataSuccess(myOrder);
    } on DioException catch (e) {
      String error = e.getError();
      print(error);
      return DataFailed(error);
    } catch (e) {
      print(e);
      return DataFailed(e.toString());
    }
  }

  @override
  Future<DataState<RecommendResponse>> getRecommend(
      RequestState<Position?> result) async {
    try {
      if (result.error == null) {
        final user = getIt<User>();
        Position? position = result.state;
        print("position ${position?.toJson()}");
        if (position != null) {
          final weather = _apiService.weatherRecommendations(
              position.longitude, position.latitude);
          final listProduct =
              _apiService.recommendation(position.longitude, position.latitude);
          final address = _getAddressFromLatLng(position);
          final response = await Future.wait([listProduct, weather, address]);
          return DataSuccess(RecommendResponse(
            user: user,
            listProduct:
                (response[0] as HttpResponse<List<ProductResponse>>).data,
            weather: (response[1] as HttpResponse<WeatherResponse?>).data,
            address: response[2] as String?,
          ));
        } else {
          final listProduct = await _apiService.getAllProducts();
          return DataSuccess(
              RecommendResponse(user: user, listProduct: listProduct.data));
        }
      } else {
        return DataFailed(result.error ?? "");
      }
    } on DioException catch (e) {
      String error = e.getError();
      print(error);
      return DataFailed(error);
    } catch (e) {
      print(e);
      return DataFailed(e.toString());
    }
  }

  Future registerStore() async {
    String? storeID = _prefs.getString("storeID");
    if (storeID != null) {
      if (getIt.isRegistered<Store>()) {
        getIt.unregister<Store>();
      }
      final store = await _storeDao.findStoreById(storeID).first;
      getIt.registerSingleton<Store>(store!.toStore());
    }
  }

  Future<String?> _getAddressFromLatLng(Position position) async {
    String? address;
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      print(place.toJson());
      address =
          '${place.street}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}';
      print(address);
    }).catchError((e) {
      print(e);
    });
    return address;
  }
}
