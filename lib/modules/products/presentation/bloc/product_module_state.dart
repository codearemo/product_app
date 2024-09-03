part of 'product_module_bloc.dart';

@immutable
sealed class ProductModuleState {}

final class ProductModuleInitial extends ProductModuleState {}

final class FetchProductsLoading extends ProductModuleState {}

final class SaveProductsLoading extends ProductModuleState {}

final class SaveProductsSuccess extends ProductModuleState {
  final GeneralResponseModel? generalResponseModel;

  SaveProductsSuccess({
    required this.generalResponseModel,
  });
}

final class SaveProductsError extends ProductModuleState {
  final String message;

  SaveProductsError({
    required this.message,
  });
}

final class FetchProductsSuccess extends ProductModuleState {
  final GeneralResponseModel<List<ProductModel?>?>? generalResponseModel;

  FetchProductsSuccess({
    required this.generalResponseModel,
  });
}

final class FetchProductsError extends ProductModuleState {
  final String message;

  FetchProductsError({
    required this.message,
  });
}
