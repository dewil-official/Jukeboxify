import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:jukeboxify/features/spotify/data/models/spotify_user_model.dart';
import 'package:jukeboxify/features/spotify/domain/entities/spotify_user_entity.dart';

import '../../../../fixtures/spotify/fixture_reader.dart';

main() {
  final exampleUserModel = SpotifyUserModel(displayName: 'Any');

  test('should extend SpotifyUserEntity', () {
    expect(exampleUserModel, isA<SpotifyUserEntity>());
  });

  group('fromJson', () {
    test('should return a valid model', () async {
      final Map<String, dynamic> rawJson = json.decode(fixture('user.json'));
      final SpotifyUserModel expectedResult =
          SpotifyUserModel(displayName: 'JM Wizzler');

      final result = SpotifyUserModel.fromJson(rawJson);

      expect(result, expectedResult);
    });
  });
}
