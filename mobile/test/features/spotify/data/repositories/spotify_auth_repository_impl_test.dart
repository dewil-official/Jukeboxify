import 'package:flutter_test/flutter_test.dart';
import 'package:jukeboxify/features/spotify/data/datasources/spotify_client.dart';
import 'package:jukeboxify/features/spotify/data/repositories/spotify_auth_repository_impl.dart';
import 'package:mockito/mockito.dart';

class MockSpotifyClient extends Mock implements SpotifyClient {}

main() {
  MockSpotifyClient mockSpotifyClient;
  SpotifyAuthRepositoryImpl repository;

  setUp(() {
    mockSpotifyClient = MockSpotifyClient();
    repository = SpotifyAuthRepositoryImpl();
  });

  group('getToken', () {
    test('returns a Token when available', () {
      final result = repository.getToken();
    }, skip: 'TODO');
  });

  group('hasToken', () {
    test('returns a Boolean', () {});
  }, skip: 'TODO');

  group('isTokenExpired', () {
    test('returns a Boolean', () {});
  }, skip: 'TODO');

  group('promptLogin', () {
    test('returns a Boolean', () {});
  }, skip: 'TODO');

  group('refreshToken', () {
    test('requests a new Token', () {});
  }, skip: 'TODO');
}
