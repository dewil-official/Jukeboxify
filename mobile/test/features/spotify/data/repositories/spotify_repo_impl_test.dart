import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jukeboxify/core/error/exceptions.dart';
import 'package:jukeboxify/core/error/failures.dart';
import 'package:jukeboxify/features/spotify/data/datasources/spotify_client.dart';
import 'package:jukeboxify/features/spotify/data/models/spotify_user_model.dart';
import 'package:jukeboxify/features/spotify/data/repositories/spotify_repo_impl.dart';
import 'package:mockito/mockito.dart';

class MockSpotifyClient extends Mock implements SpotifyClient {}

main() {
  MockSpotifyClient mockSpotifyClient;
  SpotifyRepoImpl repository;

  setUp(() {
    mockSpotifyClient = MockSpotifyClient();
    repository = SpotifyRepoImpl(spotifyClient: mockSpotifyClient);
  });

  group('getSpotifyUser', () {
    test('returns a SpotifyUserEntity when successful', () async {
      final spotifyUser = SpotifyUserModel(displayName: 'Günther');

      when(mockSpotifyClient.getSpotifyUser())
          .thenAnswer((_) => Future.value(spotifyUser));

      final result = await repository.getSpotifyUser();

      expect(result, Right(spotifyUser));
      verify(mockSpotifyClient.getSpotifyUser());
      verifyNoMoreInteractions(mockSpotifyClient);
    });

    test('returns a Failure when failed', () async {
      when(mockSpotifyClient.getSpotifyUser())
          .thenThrow(SpotifyServerException());

      final result = await repository.getSpotifyUser();

      expect(result, Left(SpotifyServerFailure()));
      verify(mockSpotifyClient.getSpotifyUser());
      verifyNoMoreInteractions(mockSpotifyClient);
    });
  });
}
