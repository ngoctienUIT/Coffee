import '../../../domain/repositories/tag/tag_response.dart';

abstract class TagState {}

class InitState extends TagState {}

class TagLoading extends TagState {}

class TagLoaded extends TagState {
  final List<TagResponse> listTag;

  TagLoaded(this.listTag);
}

class TagError extends TagState {
  final String? message;
  TagError(this.message);
}
