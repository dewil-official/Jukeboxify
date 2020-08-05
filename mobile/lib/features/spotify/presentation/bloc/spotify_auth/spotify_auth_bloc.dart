import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'spotify_auth_event.dart';
part 'spotify_auth_state.dart';

class SpotifyAuthBloc extends Bloc<SpotifyAuthEvent, SpotifyAuthState> {
  SpotifyAuthBloc() : super(SpotifyAuthState.loading);

  @override
  Stream<SpotifyAuthState> mapEventToState(
    SpotifyAuthEvent event,
  ) async* {
    if (event is ResetAuth) yield SpotifyAuthState.loading;
    if (event is LoadedAuth) yield SpotifyAuthState.success;
    if (event is FailedAuth) yield SpotifyAuthState.failure;
  }
}
