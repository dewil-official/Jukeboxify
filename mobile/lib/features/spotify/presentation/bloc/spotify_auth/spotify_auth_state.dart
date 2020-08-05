part of 'spotify_auth_bloc.dart';

abstract class SpotifyAuthState extends Equatable {
  const SpotifyAuthState();
}

class SpotifyAuthLoading extends SpotifyAuthState {
  @override
  List<Object> get props => [];
}

class SpotifyAuthSuccess extends SpotifyAuthState {
  @override
  List<Object> get props => [];
}

class SpotifyAuthFailure extends SpotifyAuthState {
  @override
  List<Object> get props => [];
}
