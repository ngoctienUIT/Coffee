import 'package:coffee_admin/src/core/use_cases/use_case.dart';
import 'package:coffee_admin/src/data/models/tag.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../../data/remote/response/tag/tag_response.dart';
import '../../repositories/tag_repository.dart';

@lazySingleton
class UpdateTagUseCase extends UseCase<DataState<TagResponse>, Tag> {
  final TagRepository _repository;

  UpdateTagUseCase(this._repository);

  @override
  Future<DataState<TagResponse>> call({required Tag params}) {
    return _repository.updateTag(params);
  }
}
