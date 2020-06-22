import 'dart:convert';

import 'package:jukeboxify/core/error/exceptions.dart';
import 'package:jukeboxify/core/error/failures.dart';
import 'package:jukeboxify/features/spotify/data/models/spotify_user_model.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/oauth2_helper.dart';
import 'package:meta/meta.dart';

class SpotifyClient {
  final OAuth2Helper oAuth2Helper;

  SpotifyClient({@required this.oAuth2Helper});

  Future<SpotifyUserModel> getSpotifyUser() async {
    const String REQUEST_URL = 'https://api.spotify.com/v1/me';

    final response = await oAuth2Helper.get(REQUEST_URL);

    if (response.statusCode == 200) {
      return SpotifyUserModel.fromJson(json.decode(response.body));
    } else {
      throw SpotifyServerException();
    }
  }
}
