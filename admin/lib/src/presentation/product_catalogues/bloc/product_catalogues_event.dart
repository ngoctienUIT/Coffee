abstract class ProductCataloguesEvent {}

class FetchData extends ProductCataloguesEvent {}

class DeleteEvent extends ProductCataloguesEvent {
  String id;

  DeleteEvent(this.id);
}