import 'package:dio/dio.dart';

extension GetError on DioException {
  String getError() {
    return response?.data.toString() ?? toString();
  }
}
