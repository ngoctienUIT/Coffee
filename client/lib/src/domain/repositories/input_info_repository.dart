import 'package:coffee/src/core/resources/data_state.dart';

import '../../core/request/input_info_request/input_info_request.dart';

abstract class InputInfoRepository {
  Future<DataState<dynamic>> submitInfo(InputInfoRequest request);
}
