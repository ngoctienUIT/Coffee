import 'package:coffee_admin/src/core/use_cases/use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../core/resources/data_state.dart';
import '../../../data/remote/response/recommend/recommend_response.dart';
import '../../repositories/recommend_repository.dart';

@lazySingleton
class GetRecommendUseCase
    extends UseCase<DataState<List<RecommendResponse>>, dynamic> {
  final RecommendRepository _repository;

  GetRecommendUseCase(this._repository);

  @override
  Future<DataState<List<RecommendResponse>>> call({params}) {
    return _repository.getRecommend();
  }
}
