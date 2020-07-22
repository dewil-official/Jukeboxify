import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
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
    test('returns a SpotifyUser if successful', () async {
      // arrange
      String jsonResponse = fixture('user.json');
      final apiResponse = Response(jsonResponse, 200);
      final expectedResult =
          SpotifyUserModel.fromJson(json.decode(jsonResponse));

      when(mockOAuth2Helper.get(argThat(isA<String>())))
          .thenAnswer((_) => Future.value(apiResponse));
      // act
      final result = await spotifyClient.getSpotifyUser();
      // assert
      expect(result, expectedResult);

      verify(mockOAuth2Helper.get(argThat(isA<String>())));
      verifyNoMoreInteractions(mockOAuth2Helper);
    });
    test('throws Exception on Network failure', () async {
      final apiResponse = Response('', 408);
      when(mockOAuth2Helper.get(any))
          .thenAnswer((_) => Future.value(apiResponse));

      try {
        await spotifyClient.getSpotifyUser();
      } catch (e) {
        expect(e, isA<Exception>());
      }
    });
    test('throws Exception on library failure', () async {
      // arrange
      when(mockOAuth2Helper.get(any)).thenAnswer((_) => Future.value(null));
      // act
      try {
        await spotifyClient.getSpotifyUser();
      } catch (e) {
        // assert
        expect(e, isA<Exception>());
      }
    });
  });
}
