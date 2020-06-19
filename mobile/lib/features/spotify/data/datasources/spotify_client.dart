import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/oauth2_helper.dart';
import 'package:meta/meta.dart';

class SpotifyClient {
  final OAuth2Helper apiClient;

  SpotifyClient({@required this.apiClient});

  Future<bool> hasToken() async {
    AccessTokenResponse token = await apiClient.getToken();
    if (token.isValid()) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> getToken() {}
  Future<bool> isTokenExpired() {}
  Future<bool> promptLogin() {}
  Future refreshToken() {}
}
