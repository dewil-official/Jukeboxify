part of 'spotify_auth_bloc.dart';

abstract class SpotifyAuthEvent extends Equatable {
  const SpotifyAuthEvent();
}

class ResetAuth extends SpotifyAuthEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class LoadedAuth extends SpotifyAuthEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class FailedAuth extends SpotifyAuthEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}
