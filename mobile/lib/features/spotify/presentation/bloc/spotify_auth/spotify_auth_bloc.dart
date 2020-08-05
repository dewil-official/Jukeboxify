import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'spotify_auth_event.dart';
part 'spotify_auth_state.dart';

class SpotifyAuthBloc extends Bloc<SpotifyAuthEvent, SpotifyAuthState> {
  SpotifyAuthBloc() : super(SpotifyAuthLoading());

  @override
  Stream<SpotifyAuthState> mapEventToState(
    SpotifyAuthEvent event,
  ) async* {
    if (event is ResetAuth) yield SpotifyAuthLoading();
    if (event is LoadedAuth) yield SpotifyAuthSuccess();
    if (event is FailedAuth) yield SpotifyAuthFailure();
  }
}
