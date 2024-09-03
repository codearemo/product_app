import 'package:assessment/core/resolvers/product_module_dependencies.dart';
import 'package:assessment/core/storage.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuthFeatures();

  serviceLocator.registerLazySingleton<Storage>(() => StorageImpl());
}

_initAuthFeatures() {
  getProductModuleDependencies();
}
