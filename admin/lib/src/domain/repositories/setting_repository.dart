import 'package:coffee_admin/src/core/resources/data_state.dart';

abstract class SettingRepository {
  Future<DataState> deleteAccount();
}
