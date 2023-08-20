import 'package:coffee/src/core/resources/data_state.dart';

abstract class ForgotPasswordRepository {
  Future<DataState<String>> sendEmail(String email);
}
