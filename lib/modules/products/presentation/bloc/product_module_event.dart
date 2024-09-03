part of 'product_module_bloc.dart';

@immutable
sealed class ProductModuleEvent {}

class SaveProductsEvent extends ProductModuleEvent {
  final List<ProductModel?>? params;

  SaveProductsEvent({required this.params});
}

class FetchProductsEvent extends ProductModuleEvent {
  final NoParams params;

  FetchProductsEvent({required this.params});
}
