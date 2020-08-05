part of 'spotify_bloc.dart';

abstract class SpotifyState extends Equatable {
  const SpotifyState();
}

class SpotifyLoading extends SpotifyState {
  @override
  List<Object> get props => [];
}

class SpotifyLoaded extends SpotifyState {
  final SpotifyUserEntity spotifyUser;

  SpotifyLoaded({@required this.spotifyUser});

  @override
  List<Object> get props => [spotifyUser];
}

class SpotifyError extends SpotifyState {
  final Failure failure;

  SpotifyError({@required this.failure});

  @override
  List<Object> get props => [failure];
}
