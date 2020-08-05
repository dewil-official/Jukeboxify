import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jukeboxify/features/spotify/domain/usecases/get_spotify_auth_status.dart';
import 'package:jukeboxify/features/spotify/presentation/bloc/spotify_auth/spotify_auth_bloc.dart';
import 'package:mockito/mockito.dart';

class MockGetSpotifyAuthStatus extends Mock implements GetSpotifyAuthStatus {}

main() {
  MockGetSpotifyAuthStatus mockGetSpotifyAuthStatus;
  SpotifyAuthBloc bloc;

  setUp(() {
    mockGetSpotifyAuthStatus = MockGetSpotifyAuthStatus();
    bloc = SpotifyAuthBloc();
  });

  tearDown(() {
    bloc.close();
  });

  blocTest(
    'emits [] when nothing is added',
    build: () => bloc,
    expect: [],
  );

  blocTest('emits [SpotifyAuthSuccess] when [LoadedAuth] is added',
      build: () => bloc,
      act: (bloc) => bloc.add(LoadedAuth()),
      expect: [SpotifyAuthState.success]);

  blocTest('emits [SpotifyAuthFailure] when [FailedAuth] is added',
      build: () => bloc,
      act: (bloc) => bloc.add(FailedAuth()),
      expect: [SpotifyAuthState.failure]);

  blocTest(
      'emits [SpotifyAuthFailure, SpotifyAuthLoading] when [FailedAuth, ResetAuth] are added',
      build: () => bloc,
      act: (bloc) => {bloc.add(FailedAuth()), bloc.add(ResetAuth())},
      expect: [SpotifyAuthState.failure, SpotifyAuthState.loading]);
}
