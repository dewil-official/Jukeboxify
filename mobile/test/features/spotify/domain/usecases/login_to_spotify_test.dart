import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jukeboxify/core/usecases/usecase.dart';
import 'package:jukeboxify/features/spotify/domain/entities/spotify_user_entity.dart';
import 'package:jukeboxify/features/spotify/domain/repositories/spotify_api_repository.dart';
import 'package:jukeboxify/features/spotify/domain/repositories/spotify_auth_repository.dart';
import 'package:jukeboxify/features/spotify/domain/usecases/login_to_spotify.dart';
import 'package:mockito/mockito.dart';

class MockSpotifyAuthRepository extends Mock implements SpotifyAuthRepository {}

class MockSpotifyApiRepository extends Mock implements SpotifyApiRepository {}

main() {
  LoginToSpotify usecase;
  MockSpotifyAuthRepository mockSpotifyAuthRepository;
  MockSpotifyApiRepository mockSpotifyApiRepository;

  setUp(() {
    mockSpotifyAuthRepository = MockSpotifyAuthRepository();
    mockSpotifyApiRepository = MockSpotifyApiRepository();
    usecase = LoginToSpotify(
        authRepo: mockSpotifyAuthRepository, apiRepo: mockSpotifyApiRepository);
  });

  test('prompts the user and returns a SpotifyUser.', () async {
    SpotifyUser spotifyUser = SpotifyUser(displayName: 'Superman1337');

    when(mockSpotifyAuthRepository.hasToken())
        .thenAnswer((realInvocation) => Future.value(false));
    when(mockSpotifyAuthRepository.isTokenExpired())
        .thenAnswer((realInvocation) => Future.value(false));
    when(mockSpotifyAuthRepository.promptLogin())
        .thenAnswer((realInvocation) => Future.value(true));
    when(mockSpotifyApiRepository.getSpotifyUser(any))
        .thenAnswer((realInvocation) => Future.value(Right(spotifyUser)));

    final result = await usecase(NoParams());

    expect(result, Right(spotifyUser));
    verify(mockSpotifyAuthRepository.promptLogin());
    verify(mockSpotifyApiRepository.getSpotifyUser(any));
  });

  test('returns a SpotifyUser() if logged in already.', () async {
    SpotifyUser spotifyUser = SpotifyUser(displayName: 'Batman');

    when(mockSpotifyAuthRepository.hasToken())
        .thenAnswer((realInvocation) => Future.value(true));
    when(mockSpotifyAuthRepository.isTokenExpired())
        .thenAnswer((realInvocation) => Future.value(false));
    when(mockSpotifyApiRepository.getSpotifyUser(any))
        .thenAnswer((realInvocation) => Future.value(Right(spotifyUser)));

    final result = await usecase(NoParams());

    expect(result, Right(spotifyUser));
    verify(mockSpotifyAuthRepository.hasToken());
    verify(mockSpotifyAuthRepository.isTokenExpired());
    verify(mockSpotifyApiRepository.getSpotifyUser(any));
  });

  test('refreshes the token automatically', () async {
    SpotifyUser spotifyUser = SpotifyUser(displayName: 'Peter Parker');
    String testToken = '1h9hDIO0h1';

    when(mockSpotifyAuthRepository.hasToken())
        .thenAnswer((realInvocation) => Future.value(true));
    when(mockSpotifyAuthRepository.isTokenExpired())
        .thenAnswer((realInvocation) => Future.value(true));
    when(mockSpotifyAuthRepository.getToken())
        .thenAnswer((realInvocation) => Future.value(testToken));
    when(mockSpotifyApiRepository.getSpotifyUser(argThat(isA<String>())))
        .thenAnswer((realInvocation) => Future.value(Right(spotifyUser)));

    final result = await usecase(NoParams());

    expect(result, Right(spotifyUser));
    verify(mockSpotifyAuthRepository.isTokenExpired());
    verify(mockSpotifyAuthRepository.refreshToken());
    verify(mockSpotifyApiRepository.getSpotifyUser(any));
  });
}
