import 'dart:async';

import 'package:jukeboxify/features/spotify/domain/usecases/auth/is_valid_token.dart';
import 'package:jukeboxify/features/spotify/domain/usecases/auth/promptLogin.dart';
import 'package:jukeboxify/other/usecases/usecase.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jukeboxify/features/spotify/domain/usecases/auth/check_has_token.dart';

part 'spotify_auth_state.dart';
part 'spotify_auth_event.dart';

@Environment(Environment.dev)
@singleton
class SpotifyAuthBloc extends Bloc<SpotifyAuthEvent, SpotifyAuthState> {
  final CheckHasToken checkHasToken;
  final IsValidToken isValidToken;
  final PromptLogin promptLogin;

  SpotifyAuthBloc(
      {@required this.checkHasToken,
      @required this.isValidToken,
      @required this.promptLogin})
      : super(SpotifyAuthState.initial);

  @override
  Stream<SpotifyAuthState> mapEventToState(
    SpotifyAuthEvent event,
  ) async* {
    if (event == SpotifyAuthEvent.initialize) yield* _initAuth();
    if (event == SpotifyAuthEvent.reset) yield* _initAuth();
    if (event == SpotifyAuthEvent.loginUser) yield* _promptLogin();
  }

  Stream<SpotifyAuthState> _initAuth() async* {
    yield SpotifyAuthState.initializing;

    final hasToken = await checkHasToken(NoParams());

    if (!hasToken) {
      yield SpotifyAuthState.needsLogin;
    } else {
      yield SpotifyAuthState.checksToken;
      final isValid = await isValidToken(NoParams());
      yield isValid ? SpotifyAuthState.success : SpotifyAuthState.failure;
    }
  }

  Stream<SpotifyAuthState> _promptLogin() async* {
    await promptLogin(NoParams());
    yield* _initAuth();
  }
}
