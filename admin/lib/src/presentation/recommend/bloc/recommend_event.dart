abstract class RecommendEvent {}

class FetchData extends RecommendEvent {}

class UpdateData extends RecommendEvent {}

class DeleteEvent extends RecommendEvent {
  String id;

  DeleteEvent(this.id);
}
