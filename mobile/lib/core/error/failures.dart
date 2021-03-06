import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class SpotifyLoginFailure extends Failure {}

class SpotifyServerFailure extends Failure {}

class UnknownSpotifyFailure extends Failure {}
