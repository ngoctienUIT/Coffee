import 'package:coffee/src/core/resources/data_state.dart';
import 'package:coffee/src/core/utils/extensions/dio_extension.dart';

import 'package:coffee/src/data/remote/response/order/order_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/view_order_repository.dart';
import '../remote/api_service/api_service.dart';
import '../remote/firebase/firebase_service.dart';

@LazySingleton(as: ViewOrderRepository)
class ViewOrderRepositoryImpl extends ViewOrderRepository {
  ViewOrderRepositoryImpl(this._apiService, this._sharedPref);

  final ApiService _apiService;
  final SharedPreferences _sharedPref;

  @override
  Future<DataState<OrderResponse>> cancelOrder(String id) async {
    try {
      String token = _sharedPref.getString("token") ?? "";
      final response = await _apiService.cancelOrder("Bearer $token", id);
      sendPushMessageTopic(
        orderID: response.data.orderId!,
        body: "Đơn hàng ${response.data.orderId} đã được hủy thành công",
        title: "Hủy đơn hàng",
      );
      return DataSuccess(response.data);
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
  Future<DataState<OrderResponse>> getData(String id) async {
    try {
      String token = _sharedPref.getString("token") ?? "";
      final response = await _apiService.getOrderByID("Bearer $token", id);
      return DataSuccess(response.data);
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
