part of 'spotify_bloc.dart';

abstract class SpotifyEvent extends Equatable {
  const SpotifyEvent();
}

class LoadUser extends SpotifyEvent {
  @override
  List<Object> get props => [];
}
