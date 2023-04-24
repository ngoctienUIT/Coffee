import '../../../domain/repositories/recommend/recommend_response.dart';

abstract class RecommendState {}

class InitState extends RecommendState {}

class RecommendLoading extends RecommendState {}

class RecommendLoaded extends RecommendState {
  List<RecommendResponse> listRecommend;

  RecommendLoaded(this.listRecommend);
}

class RecommendError extends RecommendState {
  String error;

  RecommendError(this.error);
}
