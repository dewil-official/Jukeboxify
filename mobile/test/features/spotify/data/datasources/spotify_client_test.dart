import 'package:flutter_test/flutter_test.dart';
import 'package:jukeboxify/features/spotify/data/datasources/spotify_client.dart';
import 'package:mockito/mockito.dart';
import 'package:oauth2_client/oauth2_helper.dart';

class MockOAuth2Helper extends Mock implements OAuth2Helper {}

main() {
  MockOAuth2Helper oAuth2Helper;
  SpotifyClient spotifyClient;

  setUp(() {
    oAuth2Helper = MockOAuth2Helper();
    spotifyClient = SpotifyClient(apiClient: oAuth2Helper);
  });

  group('hasToken', () {
    test('returns a bool whether the token is valid', () {
      // TODO: Implement
    });
  });
}
