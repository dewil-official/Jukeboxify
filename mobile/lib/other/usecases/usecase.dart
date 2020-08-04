import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:jukeboxify/other/error/failures.dart';

abstract class UseCase<Type, Params> {
  dynamic call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

class Params extends Equatable {
  @override
  List<Object> get props => [];
}
