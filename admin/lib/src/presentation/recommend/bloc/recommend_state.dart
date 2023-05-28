import '../../../domain/repositories/recommend/recommend_response.dart';

abstract class RecommendState {}

class InitState extends RecommendState {}

class DeleteSuccess extends RecommendState {
  String id;

  DeleteSuccess(this.id);
}

class RecommendLoading extends RecommendState {
  bool check;

  RecommendLoading([this.check = true]);
}

class RecommendLoaded extends RecommendState {
  List<RecommendResponse> listRecommend;

  RecommendLoaded(this.listRecommend);
}

class RecommendError extends RecommendState {
  String error;

  RecommendError(this.error);
}
