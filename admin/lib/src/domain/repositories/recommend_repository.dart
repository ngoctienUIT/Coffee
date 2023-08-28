import 'package:coffee_admin/src/core/resources/data_state.dart';

import '../../data/models/recommend.dart';
import '../../data/remote/response/recommend/recommend_response.dart';

abstract class RecommendRepository {
  Future<DataState<List<RecommendResponse>>> getRecommend();

  Future<DataState> createRecommend(Recommend recommend);

  Future<DataState> updateRecommend(Recommend recommend);

  Future<DataState> deleteRecommend(String id);
}
