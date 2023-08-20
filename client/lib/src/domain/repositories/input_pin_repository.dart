import 'package:coffee/src/core/resources/data_state.dart';

import '../../core/request/input_pin_request/input_pin_request.dart';

abstract class InputPinRepository {
  Future<DataState<bool>> sendApi(InputPinRequest request);
}
