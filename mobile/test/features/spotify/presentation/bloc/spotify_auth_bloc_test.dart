import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jukeboxify/features/spotify/domain/usecases/auth/check_has_token.dart';
import 'package:jukeboxify/features/spotify/domain/usecases/auth/is_valid_token.dart';
import 'package:jukeboxify/features/spotify/domain/usecases/auth/promptLogin.dart';
import 'package:jukeboxify/features/spotify/presentation/bloc/spotify_auth/spotify_auth_bloc.dart';
import 'package:mockito/mockito.dart';

class MockCheckHasToken extends Mock implements CheckHasToken {}

class MockIsValidToken extends Mock implements IsValidToken {}

class MockPromptLogin extends Mock implements PromptLogin {}

main() {
  MockCheckHasToken checkHasToken;
  MockIsValidToken isValidToken;
  MockPromptLogin promptLogin;
  SpotifyAuthBloc bloc;

  setUp(() {
    checkHasToken = MockCheckHasToken();
    isValidToken = MockIsValidToken();
    promptLogin = MockPromptLogin();
    bloc = SpotifyAuthBloc(
        checkHasToken: checkHasToken,
        isValidToken: isValidToken,
        promptLogin: promptLogin);
  });

  tearDown(() {
    bloc.close();
  });

  blocTest(
    'emits [] when nothing is added',
    build: () => bloc,
    expect: [],
  );

  blocTest(
    'emits [initializing, needsLogin] when no token is stored',
    build: () {
      when(checkHasToken.call(any)).thenAnswer((_) => Future.value(false));
      return bloc;
    },
    act: (bloc) => bloc.add(SpotifyAuthEvent.initialize),
    expect: [SpotifyAuthState.initializing, SpotifyAuthState.needsLogin],
  );

  blocTest(
    'emits [initializing, checksToken, success] when a valid token is stored',
    build: () {
      when(checkHasToken.call(any)).thenAnswer((_) => Future.value(true));
      when(isValidToken.call(any)).thenAnswer((_) => Future.value(true));
      return bloc;
    },
    act: (bloc) => bloc.add(SpotifyAuthEvent.initialize),
    expect: [
      SpotifyAuthState.initializing,
      SpotifyAuthState.checksToken,
      SpotifyAuthState.success
    ],
  );

  // TODO: Find out whether an invalid token could be automatically refreshed.
  blocTest(
    'emits [initializing, checksToken, failure] when an invalid token is stored',
    build: () {
      when(checkHasToken.call(any)).thenAnswer((_) => Future.value(true));
      when(isValidToken.call(any)).thenAnswer((_) => Future.value(false));
      return bloc;
    },
    act: (bloc) => bloc.add(SpotifyAuthEvent.initialize),
    expect: [
      SpotifyAuthState.initializing,
      SpotifyAuthState.checksToken,
      SpotifyAuthState.failure
    ],
  );

  blocTest(
    'runs promptLogin when [loginUser] is emitted',
    build: () => bloc,
    act: (bloc) => bloc.add(SpotifyAuthEvent.loginUser),
    verify: (bloc) {
      verify(promptLogin.call(any)).called(1);
    },
  );
}
