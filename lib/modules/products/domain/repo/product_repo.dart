import 'package:assessment/core/error/failure.dart';
import 'package:assessment/core/models/general_response_model.dart';
import 'package:assessment/modules/products/data/models/product_model.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ProductRepo {
  Future<Either<Failure, GeneralResponseModel<List<ProductModel?>?>?>> fetchProducts();
  Future<Either<Failure, GeneralResponseModel?>> saveProducts(List<ProductModel?>? params);
}