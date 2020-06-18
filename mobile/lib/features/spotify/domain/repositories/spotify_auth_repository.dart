import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/spotify_user.dart';

abstract class SpotifyAuthRepository {
  // The token is being saved internally,
  // so I only request it when needed for
  // non-auth requests.
  Future<bool> promptLogin() {}
  Future<bool> hasToken() {}
  Future<bool> isTokenExpired() {}
  Future refreshToken() {}
  Future<String> getToken() {}
}
