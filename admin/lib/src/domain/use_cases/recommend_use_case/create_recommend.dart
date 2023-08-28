import 'package:coffee_admin/src/core/use_cases/use_case.dart';
import 'package:coffee_admin/src/data/models/recommend.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../repositories/recommend_repository.dart';

@lazySingleton
class CreateRecommendUseCase extends UseCase<DataState, Recommend> {
  final RecommendRepository _repository;

  CreateRecommendUseCase(this._repository);

  @override
  Future<DataState> call({required Recommend params}) {
    return _repository.createRecommend(params);
  }
}
