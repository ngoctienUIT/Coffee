import 'package:coffee/src/core/resources/data_state.dart';

abstract class SettingRepository {
  Future<DataState> deleteAccount();
}
