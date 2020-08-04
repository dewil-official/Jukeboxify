import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class Failure extends Equatable {
  final String message;

  Failure({@required this.message});

  @override
  List<Object> get props => [message];
}

class SpotifyLoginFailure extends Failure {
  SpotifyLoginFailure({@required message}) : super(message: message);
}

class SpotifyServerFailure extends Failure {
  SpotifyServerFailure({@required message}) : super(message: message);
}

class UnknownSpotifyFailure extends Failure {
  UnknownSpotifyFailure({@required message}) : super(message: message);
}
