import 'package:equatable/equatable.dart';

import '../../../data/remote/response/recommend/recommend_response.dart';

abstract class RecommendState extends Equatable {}

class InitState extends RecommendState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class DeleteSuccess extends RecommendState {
  final String id;

  DeleteSuccess(this.id);

  @override
  List<Object?> get props => [id];
}

class RecommendLoading extends RecommendState {
  final bool check;

  RecommendLoading([this.check = true]);

  @override
  List<Object?> get props => [check];
}

class RecommendLoaded extends RecommendState {
  final List<RecommendResponse> listRecommend;

  RecommendLoaded(this.listRecommend);

  @override
  List<Object?> get props => [listRecommend];
}

class RecommendError extends RecommendState {
  final String error;

  RecommendError(this.error);

  @override
  List<Object?> get props => [error];
}
