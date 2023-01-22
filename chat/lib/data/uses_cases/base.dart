import 'package:chat/data/repository/base.dart';

class Params {}

abstract class UseCase<Type, Params> {
  final Repository? repository;
  UseCase({this.repository});

  Future<Type> call({required Params params});
}

abstract class UseCaseNoParams<Type> {
  Future<Type> call();
}

class UseCaseException implements Exception {
  final String message;
  UseCaseException(this.message);
}
