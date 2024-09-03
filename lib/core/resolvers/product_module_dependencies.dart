import 'package:assessment/core/resolvers/init_dependencies.dart';
import 'package:assessment/modules/products/data/datasource/local/product_local_datasource.dart';
import 'package:assessment/modules/products/data/datasource/local/product_local_datasource_impl.dart';
import 'package:assessment/modules/products/data/repo/product_repo_impl.dart';
import 'package:assessment/modules/products/domain/repo/product_repo.dart';
import 'package:assessment/modules/products/domain/usecases/fetch_products_usecase.dart';
import 'package:assessment/modules/products/domain/usecases/save_products_usecase.dart';
import 'package:assessment/modules/products/presentation/bloc/product_module_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt getProductModuleDependencies() {
  return serviceLocator
    ..registerFactory<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(),
    )
    ..registerFactory<ProductRepo>(
      () => ProductRepoImpl(
        productLocalDataSource: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => FetchProductsUsecase(
        productRepo: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => SaveProductsUsecase(
        productRepo: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => ProductModuleBloc(
        fetchProductsUsecase: serviceLocator(),
        saveProductsUsecase: serviceLocator(),
      ),
    );
}
