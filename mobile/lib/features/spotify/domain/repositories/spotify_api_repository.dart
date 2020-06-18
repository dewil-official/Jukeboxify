import 'package:dartz/dartz.dart';
import 'package:jukeboxify/core/error/failures.dart';
import 'package:jukeboxify/features/spotify/domain/entities/spotify_user.dart';

abstract class SpotifyApiRepository {
  Future<Either<Failure, SpotifyUser>> getSpotifyUser(String accessToken) {}
}
