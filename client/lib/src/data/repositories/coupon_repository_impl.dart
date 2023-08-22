import 'package:coffee/injection.dart';
import 'package:coffee/src/core/resources/data_state.dart';
import 'package:coffee/src/core/utils/extensions/dio_extension.dart';
import 'package:coffee/src/core/utils/extensions/list_extension.dart';
import 'package:coffee/src/data/remote/api_service/api_service.dart';

import 'package:coffee/src/data/remote/response/coupon/coupon_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/coupon_repository.dart';
import '../models/user.dart';

@LazySingleton(as: CouponRepository)
class CouponRepositoryImpl extends CouponRepository {
  CouponRepositoryImpl(this._apiService);

  final ApiService _apiService;

  @override
  Future<DataState<List<CouponResponse>>> getData() async {
    try {
      User? user = getIt<User>();
      final response = await _apiService.getAvailableCoupons(user.id);
      return DataSuccess(response.data.filterCoupon());
    } on DioException catch (e) {
      String error = e.getError();
      print(error);
      return DataFailed(error);
    } catch (e) {
      print(e);
      return DataFailed(e.toString());
    }
  }
}
