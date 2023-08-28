import 'package:coffee_admin/src/core/resources/data_state.dart';
import 'package:coffee_admin/src/core/utils/extensions/dio_extension.dart';
import 'package:coffee_admin/src/core/utils/extensions/string_extension.dart';
import 'package:coffee_admin/src/data/local/dao/user_dao.dart';
import 'package:coffee_admin/src/data/models/user.dart';

import 'package:coffee_admin/src/data/remote/response/order/order_response.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/request/order_request/order_request.dart';
import '../../core/response/order_response/get_order_response.dart';
import '../../domain/repositories/order_repository.dart';
import '../remote/api_service/api_service.dart';
import '../remote/firebase/firebase_service.dart';

@LazySingleton(as: OrderRepository)
class OrderRepositoryImpl extends OrderRepository {
  final ApiService _apiService;
  final SharedPreferences _sharedPref;
  final UserDao _userDao;

  OrderRepositoryImpl(this._apiService, this._sharedPref, this._userDao);

  @override
  Future<DataState<OrderResponse>> cancelOrder(OrderRequest request) async {
    try {
      final token = _sharedPref.get("token") ?? "";
      final response =
          await _apiService.cancelOrder("Bearer $token", request.id);
      sendPushMessage(
        token: await getTokenFCM(request.userID),
        orderID: request.id,
        body: "Đơn hàng ${request.id} đã được hủy thành công",
        title: "Đơn hàng bị hủy",
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
  Future<DataState<List<OrderResponse>>> getListOrder(String status) async {
    try {
      final token = _sharedPref.get("token") ?? "";
      final response =
          await _apiService.getAllOrders('Bearer $token', "", status);
      final listOrder = status.isNotEmpty
          ? response.data
          : response.data
              .where((element) => element.orderStatus != "PENDING")
              .toList();
      listOrder.sort((a, b) => b.createdDate!
          .toDateTime2()
          .difference(a.createdDate!.toDateTime2())
          .inSeconds);
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
  Future<DataState<GetOrderResponse>> getOrderByID(String id) async {
    try {
      final token = _sharedPref.get("token") ?? "";
      final orderResponse = await _apiService.getOrderByID("Bearer $token", id);
      final user =
          await _userDao.findUserById(orderResponse.data.userId!).first;
      if (user != null) {
        return DataSuccess(GetOrderResponse(
          user: user.toUser(),
          order: orderResponse.data,
        ));
      } else {
        final userResponse = await _apiService.getUserByID(
            "Bearer $token", orderResponse.data.userId!);
        _userDao.insertUser(userResponse.data.toUserEntity());
        return DataSuccess(GetOrderResponse(
          user: User.fromUserResponse(userResponse.data),
          order: orderResponse.data,
        ));
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

  @override
  Future<DataState<OrderResponse>> orderCompleted(OrderRequest request) async {
    try {
      final token = _sharedPref.get("token") ?? "";
      final response =
          await _apiService.closeSuccessOrder("Bearer $token", request.id);
      sendPushMessage(
        token: await getTokenFCM(request.userID),
        orderID: request.id,
        body: "Đơn hàng ${request.id} đã được xác nhận thành công",
        title: "Đơn hàng đã xác nhận",
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
}
