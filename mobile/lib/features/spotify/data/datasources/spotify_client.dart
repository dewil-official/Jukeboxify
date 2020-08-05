import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:jukeboxify/other/error/exceptions.dart';
import 'package:jukeboxify/features/spotify/data/models/spotify_user_model.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';
import 'package:meta/meta.dart';

@module
abstract class RegisterModule {
  @Named('OAuth2Client')
  OAuth2Client get oAuth2Client => OAuth2Client(
      authorizeUrl: 'https://accounts.spotify.com/authorize',
      tokenUrl: 'https://accounts.spotify.com/api/token',
      redirectUri: 'app.jukeboxify.mobile://oauth2redirect',
      customUriScheme: 'app.jukeboxify.mobile');

  @singleton
  OAuth2Helper oAuth2Helper(@Named("OAuth2Client") OAuth2Client helper) =>
      OAuth2Helper(helper,
          grantType: OAuth2Helper.AUTHORIZATION_CODE,
          clientId: '0f883a103e00477e8a03b145ef8157ab',
          scopes: ['user-modify-playback-state']);
}

@Environment(Environment.dev)
@singleton
class SpotifyClient {
  final OAuth2Helper oAuth2Helper;

  SpotifyClient({@required this.oAuth2Helper});

  Future<SpotifyUserModel> getSpotifyUser() async {
    const String REQUEST_URL = 'https://api.spotify.com/v1/me';

    final response = await oAuth2Helper.get(REQUEST_URL);

    if (response?.statusCode == 200) {
      return SpotifyUserModel.fromJson(json.decode(response.body));
    } else {
      throw SpotifyServerException();
    }
  }

  Future<bool> hasValidAccessToken() async {
    final token = await this.oAuth2Helper.getTokenFromStorage();
    bool isValid = false;
    try {
      isValid = token.isValid();
    } on NoSuchMethodError {
      return false;
    }
    return isValid;
  }

  Future<bool> hasToken() async {
    final token = await oAuth2Helper.getTokenFromStorage();
    return token != null;
  }

  Future<bool> isValidToken() async {
    try {
      // Does an example API request to validate the token.
      await getSpotifyUser();
    } catch (e) {}
    final token = await this.oAuth2Helper.getTokenFromStorage();
    if (!token.isValid() || token.isExpired()) {
      return false;
    } else {
      return true;
    }
  }

  Future promptLogin() async {
    await oAuth2Helper.getToken();
  }
}
