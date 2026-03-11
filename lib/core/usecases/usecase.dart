import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:routiner/core/error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Use for use cases that take no parameters (e.g. getCurrentUser, signOut, signInWithGoogle).
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object> get props => [];
}
