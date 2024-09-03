import 'package:assessment/core/models/general_response_model.dart';
import 'package:assessment/modules/products/data/models/product_model.dart';

abstract interface class ProductLocalDataSource {
  Future<GeneralResponseModel<List<ProductModel?>?>?>? fetchProducts();
  Future<GeneralResponseModel?> saveProducts(List<ProductModel?>? params);
}