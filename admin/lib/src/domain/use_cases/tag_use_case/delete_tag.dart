import 'package:coffee_admin/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../../data/remote/response/tag/tag_response.dart';
import '../../repositories/tag_repository.dart';

@lazySingleton
class DeleteTagUseCase extends UseCase<DataState<TagResponse>, String> {
  final TagRepository _repository;

  DeleteTagUseCase(this._repository);

  @override
  Future<DataState<TagResponse>> call({required String params}) {
    return _repository.deleteTag(params);
  }
}
