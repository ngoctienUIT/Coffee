import 'package:equatable/equatable.dart';

abstract class ProductCataloguesEvent extends Equatable {}

class FetchData extends ProductCataloguesEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class UpdateData extends ProductCataloguesEvent {
  @override
  List<Object?> get props => [identityHashCode(this)];
}

class DeleteEvent extends ProductCataloguesEvent {
  final String id;

  DeleteEvent(this.id);

  @override
  List<Object?> get props => [id];
}
