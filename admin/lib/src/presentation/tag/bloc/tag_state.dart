import 'package:equatable/equatable.dart';

import '../../../data/remote/response/tag/tag_response.dart';

abstract class TagState extends Equatable {}

class InitState extends TagState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class DeleteSuccess extends TagState {
  final String id;

  DeleteSuccess(this.id);

  @override
  List<Object?> get props => [id];
}

class TagLoading extends TagState {
  final bool check;

  TagLoading([this.check = true]);

  @override
  List<Object?> get props => [check];
}

class TagLoaded extends TagState {
  final List<TagResponse> listTag;

  TagLoaded(this.listTag);

  @override
  List<Object?> get props => [listTag];
}

class TagError extends TagState {
  final String? message;

  TagError(this.message);

  @override
  List<Object?> get props => [message];
}

class PickState extends TagState {
  @override
  List<Object?> get props => [identityHashCode(this)];
}
