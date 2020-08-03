import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jukeboxify/core/error/failures.dart';
import 'package:jukeboxify/features/spotify/domain/entities/spotify_user_entity.dart';
import 'package:jukeboxify/features/spotify/domain/usecases/get_spotify_profile.dart';
import 'package:jukeboxify/features/spotify/presentation/bloc/spotify/spotify_bloc.dart';
import 'package:mockito/mockito.dart';

class MockGetSpotifyProfile extends Mock implements GetSpotifyProfile {}

main() {
  MockGetSpotifyProfile mockGetSpotifyProfile;
  SpotifyBloc spotifyBloc;
  SpotifyUserEntity spotifyUser;

  setUp(() {
    mockGetSpotifyProfile = MockGetSpotifyProfile();
    spotifyBloc = SpotifyBloc(getSpotifyProfile: mockGetSpotifyProfile);
    spotifyUser = SpotifyUserEntity(displayName: 'Carl');
  });

  blocTest(
    'emits [] when nothing is added',
    build: () => spotifyBloc,
    expect: [],
  );

  test(
    'should by [SpotifyInitial] first and emit [SpotifyLoaded] after loading the data.',
    () async {
      // arrange
      when(mockGetSpotifyProfile(any))
          .thenAnswer((_) async => Right(spotifyUser));
      // assert later
      final spotifyLoadedState = SpotifyLoaded(spotifyUser: spotifyUser);
      expect(spotifyBloc.state, isA<SpotifyInitial>());
      expectLater(spotifyBloc, emits(spotifyLoadedState));
      // act
      spotifyBloc.add(LoadUser());
    },
  );

  test(
    'should emit [SpotifyInitial, SpotifyError] when getting data fails',
    () async {
      // arrange
      final failure = SpotifyServerFailure(message: 'Test Server Failure.');
      final spotifyErrorState = SpotifyError(failure: failure);
      when(mockGetSpotifyProfile(any)).thenAnswer((_) async => Left(failure));
      // assert
      expect(spotifyBloc.state, isA<SpotifyInitial>());
      expectLater(spotifyBloc, emits(spotifyErrorState));
      // act
      spotifyBloc.add(LoadUser());
    },
  );
}
