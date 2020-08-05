import 'dart:async';

import 'package:bloc/bloc.dart';

class SpotifyAuthBloc extends Bloc<SpotifyAuthEvent, SpotifyAuthState> {
  SpotifyAuthBloc() : super(SpotifyAuthState.loading);

  @override
  Stream<SpotifyAuthState> mapEventToState(
    SpotifyAuthEvent event,
  ) async* {
    if (event == SpotifyAuthEvent.reset) yield SpotifyAuthState.loading;
    if (event == SpotifyAuthEvent.loaded) yield SpotifyAuthState.success;
    if (event == SpotifyAuthEvent.failed) yield SpotifyAuthState.failure;
  }
}

enum SpotifyAuthState { loading, success, failure }

enum SpotifyAuthEvent {
  reset,
  loaded,
  failed,
}
