import 'package:coffee_admin/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../../data/remote/response/tag/tag_response.dart';
import '../../repositories/tag_repository.dart';

@lazySingleton
class GetTagUseCase extends UseCase<DataState<List<TagResponse>>, dynamic> {
  final TagRepository _repository;

  GetTagUseCase(this._repository);

  @override
  Future<DataState<List<TagResponse>>> call({params}) {
    return _repository.getTag();
  }
}
