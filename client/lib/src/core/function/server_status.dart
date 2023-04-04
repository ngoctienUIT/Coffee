import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

String? serverStatus(dynamic error) {
  switch (error.runtimeType) {
    case DioError:
      final res = (error as DioError).response;
      Fluttertoast.showToast(msg: res!.data.toString());
      return res.data.toString();
    default:
      return null;
  }
}
