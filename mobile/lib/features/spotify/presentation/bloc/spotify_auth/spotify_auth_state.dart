part of 'spotify_auth_bloc.dart';

enum SpotifyAuthState {
  /// When waiting for the app to load.
  initial,

  /// When checking, whether the user has logged in to Spotify.
  initializing,

  /// When there is no auth token stored.
  needsLogin,

  /// When there is a token, that is being validated.
  checksToken,

  /// When there is a validated token.
  success,

  /// When anything went wrong and the user needs to restart the process.
  failure,
}
