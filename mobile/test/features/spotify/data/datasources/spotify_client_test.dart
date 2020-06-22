import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:jukeboxify/core/error/exceptions.dart';
import 'package:jukeboxify/features/spotify/data/datasources/spotify_client.dart';
import 'package:jukeboxify/features/spotify/data/models/spotify_user_model.dart';
import 'package:mockito/mockito.dart';
import 'package:oauth2_client/oauth2_helper.dart';
import 'package:matcher/matcher.dart';

import '../../../../fixtures/spotify/fixture_reader.dart';

class MockOAuth2Helper extends Mock implements OAuth2Helper {}

main() {
  MockOAuth2Helper mockOAuth2Helper;
  SpotifyClient spotifyClient;

  setUp(() {
    mockOAuth2Helper = MockOAuth2Helper();
    spotifyClient = SpotifyClient(oAuth2Helper: mockOAuth2Helper);
  });

  group('getSpotifyUser', () {
    test('gets a SpotifyUser from oAuth2Helper library', () async {
      String jsonResponse = fixture('user.json');
      final apiResponse = Response(jsonResponse, 200);
      final expectedResult =
          SpotifyUserModel.fromJson(json.decode(jsonResponse));

      when(mockOAuth2Helper.get(argThat(isA<String>())))
          .thenAnswer((_) => Future.value(apiResponse));

      final result = await spotifyClient.getSpotifyUser();

      expect(result, expectedResult);

      verify(mockOAuth2Helper.get(argThat(isA<String>())));
      verifyNoMoreInteractions(mockOAuth2Helper);
    });
    test('returns a Failure if http request fails', () async {
      final apiResponse = Response('', 408);
      when(mockOAuth2Helper.get(any))
          .thenAnswer((_) => Future.value(apiResponse));

      try {
        await spotifyClient.getSpotifyUser();
      } catch (e) {
        expect(e, isA<Exception>());
      }
    });
  });
}
