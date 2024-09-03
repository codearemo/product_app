import 'package:assessment/core/error/failure.dart';
import 'package:assessment/core/models/general_response_model.dart';
import 'package:assessment/core/usecases/general_usecase.dart';
import 'package:assessment/modules/products/data/models/product_model.dart';
import 'package:assessment/modules/products/domain/repo/product_repo.dart';
import 'package:fpdart/fpdart.dart';

class FetchProductsUsecase implements GeneralUsecase<GeneralResponseModel<List<ProductModel?>?>?, NoParams> {
  final ProductRepo productRepo;

  FetchProductsUsecase({
    required this.productRepo,
  });

  @override
  Future<Either<Failure, GeneralResponseModel<List<ProductModel?>?>?>> call(NoParams params) async {
    return await productRepo.fetchProducts();
  }
}