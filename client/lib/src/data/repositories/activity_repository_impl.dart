import 'package:coffee/src/core/resources/data_state.dart';
import 'package:coffee/src/core/utils/extensions/list_extension.dart';
import 'package:coffee/src/data/local/dao/user_dao.dart';
import 'package:coffee/src/data/local/entity/user_entity.dart';

import 'package:coffee/src/data/remote/response/order/order_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/activity_repository.dart';
import '../remote/api_service/api_service.dart';

@LazySingleton(as: ActivityRepository)
class ActivityRepositoryImpl extends ActivityRepository {
  final ApiService _apiService;
  final SharedPreferences _sharedPref;
  final UserDao _userDao;

  ActivityRepositoryImpl(this._apiService, this._sharedPref, this._userDao);

  @override
  Future<DataState<List<OrderResponse>>> getData(int index) async {
    try {
      String token = _sharedPref.getString("token") ?? "";
      String userID = _sharedPref.getString("userID") ?? "";
      UserEntity? user = await _userDao.findUserById(userID).first;
      List<OrderResponse> listOrder;
      final response = index == 0
          ? await _apiService.getAllOrders(
              "Bearer $token", user!.username, "PLACED")
          : await _apiService.getAllOrders("Bearer $token", user!.username, "");
      listOrder =
          index == 0 ? response.data : response.data.filterCompleteOrCancel();
      listOrder.sortByTime();
      return DataSuccess(listOrder);
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
