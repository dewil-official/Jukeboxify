import 'package:dartz/dartz.dart';
import 'package:jukeboxify/core/error/failure.dart';
import 'package:jukeboxify/features/spotify/domain/entities/spotify_user.dart';

abstract class SpotifyApiRepository {
  Future<Either<Failure, SpotifyUser>> getSpotifyUser(String accessToken) {}
}
