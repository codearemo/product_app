import 'package:assessment/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class GeneralUsecase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

// For usecase that need no params
class NoParams {}