import 'package:coffee_admin/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../repositories/recommend_repository.dart';

@lazySingleton
class DeleteRecommendUseCase extends UseCase<DataState, String> {
  final RecommendRepository _repository;

  DeleteRecommendUseCase(this._repository);

  @override
  Future<DataState> call({required String params}) {
    return _repository.deleteRecommend(params);
  }
}
