import 'package:assessment/core/error/exceptions.dart';
import 'package:assessment/core/error/failure.dart';
import 'package:assessment/core/models/general_response_model.dart';
import 'package:assessment/modules/products/data/datasource/local/product_local_datasource.dart';
import 'package:assessment/modules/products/data/models/product_model.dart';
import 'package:assessment/modules/products/domain/repo/product_repo.dart';
import 'package:fpdart/fpdart.dart';

class ProductRepoImpl implements ProductRepo {
  final ProductLocalDataSource productLocalDataSource;

  ProductRepoImpl({
    required this.productLocalDataSource,
  });

  @override
  Future<Either<Failure, GeneralResponseModel<List<ProductModel?>?>?>> fetchProducts() async {
    try {
      return right(await productLocalDataSource.fetchProducts());
      
    } on DatasourceException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, GeneralResponseModel?>> saveProducts(List<ProductModel?>? params) async {
    try {
      return right(await productLocalDataSource.saveProducts(params));
      
    } on DatasourceException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}