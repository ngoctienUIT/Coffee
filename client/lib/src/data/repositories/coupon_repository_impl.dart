import 'package:coffee/src/core/resources/data_state.dart';
import 'package:coffee/src/core/utils/extensions/list_extension.dart';
import 'package:coffee/src/data/remote/api_service/api_service.dart';

import 'package:coffee/src/data/remote/response/coupon/coupon_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/coupon_repository.dart';
import '../local/dao/user_dao.dart';
import '../local/entity/user_entity.dart';

@LazySingleton(as: CouponRepository)
class CouponRepositoryImpl extends CouponRepository {
  CouponRepositoryImpl(this._apiService, this._sharedPref, this._userDao);

  final ApiService _apiService;
  final SharedPreferences _sharedPref;
  final UserDao _userDao;

  @override
  Future<DataState<List<CouponResponse>>> getData() async {
    try {
      String userID = _sharedPref.getString("userID") ?? "";
      UserEntity? user = await _userDao.findUserById(userID).first;
      final response = await _apiService.getAvailableCoupons(user!.id);
      return DataSuccess(response.data.filterCoupon());
    } on DioException catch (e) {
      String error =
          e.response != null ? e.response!.data.toString() : e.toString();
      print(error);
      return DataFailed(error);
    } catch (e) {
      print(e);
      return DataFailed(e.toString());
    }
  }
}
