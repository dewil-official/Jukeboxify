part of 'spotify_auth_bloc.dart';

enum SpotifyAuthEvent {
  /// Alias for [initialize].
  reset,

  /// Will check whether the user needs to login.
  initialize,

  /// Prompts the user login dialog.
  loginUser,
}
