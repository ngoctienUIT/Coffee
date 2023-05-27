abstract class CouponEvent {}

class FetchData extends CouponEvent {}

class UpdateData extends CouponEvent {}

class DeleteEvent extends CouponEvent {
  String id;

  DeleteEvent(this.id);
}
