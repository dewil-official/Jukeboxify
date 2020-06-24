import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jukeboxify/core/error/failures.dart';
import 'package:jukeboxify/core/usecases/usecase.dart';
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
    build: () async => spotifyBloc,
    expect: [],
  );

  test(
    'should emit [Initial, Loaded] when data is gotten successfully',
    () async {
      // arrange
      when(mockGetSpotifyProfile(any))
          .thenAnswer((_) async => Right(spotifyUser));
      // assert later
      final expected = [
        SpotifyInitial(),
        SpotifyLoaded(spotifyUser: spotifyUser)
      ];
      expectLater(spotifyBloc, emitsInOrder(expected));
      // act
      spotifyBloc.add(LoadUser());
    },
  );

  test(
    'should emit [Initial, Error] when getting data fails',
    () async {
      // arrange
      final failure = SpotifyServerFailure();
      when(mockGetSpotifyProfile(any)).thenAnswer((_) async => Left(failure));
      // assert later
      final expected = [SpotifyInitial(), SpotifyError(failure: failure)];
      expectLater(spotifyBloc, emitsInOrder(expected));
      // act
      spotifyBloc.add(LoadUser());
    },
  );
}
