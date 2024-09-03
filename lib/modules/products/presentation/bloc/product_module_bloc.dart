import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:assessment/core/models/general_response_model.dart';
import 'package:assessment/core/usecases/general_usecase.dart';
import 'package:assessment/modules/products/data/models/product_model.dart';
import 'package:assessment/modules/products/domain/usecases/fetch_products_usecase.dart';
import 'package:assessment/modules/products/domain/usecases/save_products_usecase.dart';

part 'product_module_event.dart';
part 'product_module_state.dart';

class AppRange {
  final double? minValue;
  final double? maxValue;

  AppRange({
    required this.minValue,
    required this.maxValue,
  });
}

class ProductFilters {
  final List<String>? categories;
  final AppRange? priceRange;

  ProductFilters({
    this.categories,
    this.priceRange,
  });
}

class ProductModuleBloc extends Bloc<ProductModuleEvent, ProductModuleState> {
  ProductFilters? _filters;
  GeneralResponseModel<List<ProductModel?>?>? productsData;

  final FetchProductsUsecase fetchProductsUsecase;
  final SaveProductsUsecase saveProductsUsecase;

  ProductModuleBloc(
      {required this.fetchProductsUsecase, required this.saveProductsUsecase})
      : super(ProductModuleInitial()) {
    on<FetchProductsEvent>(_fetchProducts);
    on<SaveProductsEvent>(_saveProducts);
    on<ProductModuleEvent>((event, emit) {});
  }

  final List<String> _categories = [
    'Electronics',
    'Gloves',
    'Clothing',
    'Sports'
  ];

  List<String> get categories => _categories;

  double? get minValue => (productsData?.data ?? []).length <= 1
      ? 0
      : productsData?.data?.map((e) => e?.price ?? 0).reduce(min);

  double? get maxValue => (productsData?.data ?? []).isEmpty
      ? 0
      : productsData?.data?.map((e) => e?.price ?? 0).reduce(max);

  ProductFilters get filters {
    return _filters ??
        ProductFilters(
          categories: _categories,
          priceRange: AppRange(minValue: minValue, maxValue: maxValue),
        );
  }

  void setFilters(ProductFilters? filters) {
    _filters = filters;

    add(FetchProductsEvent(
      params: NoParams(),
    ));
  }

  _saveProducts(
      SaveProductsEvent event, Emitter<ProductModuleState> emit) async {
    emit(SaveProductsLoading());

    final result = await saveProductsUsecase.call(event.params);

    result.fold(
      (l) => emit(SaveProductsError(message: l.message)),
      (r) => emit(SaveProductsSuccess(generalResponseModel: r)),
    );
  }

  _fetchProducts(
      FetchProductsEvent event, Emitter<ProductModuleState> emit) async {
    emit(FetchProductsLoading());

    final result = await fetchProductsUsecase.call(event.params);

    result.fold(
      (l) => emit(FetchProductsError(message: l.message)),
      (r) {
        productsData = r;
        emit(FetchProductsSuccess(generalResponseModel: r));
      },
    );
  }
}
