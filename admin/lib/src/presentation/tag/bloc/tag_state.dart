import '../../../domain/repositories/tag/tag_response.dart';

abstract class TagState {}

class InitState extends TagState {}

class DeleteSuccess extends TagState {
  String id;

  DeleteSuccess(this.id);
}

class TagLoading extends TagState {
  bool check;

  TagLoading([this.check = true]);
}

class TagLoaded extends TagState {
  final List<TagResponse> listTag;

  TagLoaded(this.listTag);
}

class TagError extends TagState {
  final String? message;
  TagError(this.message);
}

class PickState extends TagState {}
