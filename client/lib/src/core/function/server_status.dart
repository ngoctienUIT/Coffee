import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

String? serverStatus(dynamic error) {
  switch (error.runtimeType) {
    case DioError:
      final res = (error as DioError).response;
      if (res != null) {
        Fluttertoast.showToast(msg: res.data.toString());
        return res.data.toString();
      }
      return null;
    default:
      return null;
  }
}
