import 'package:coffee/src/core/resources/data_state.dart';
import 'package:coffee/src/core/use_cases/use_case.dart';
import 'package:coffee/src/domain/repositories/setting_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeleteAccountUseCase extends UseCase<DataState, dynamic> {
  DeleteAccountUseCase(this._repository);

  final SettingRepository _repository;

  @override
  Future<DataState> call({params}) {
    return _repository.deleteAccount();
  }
}
