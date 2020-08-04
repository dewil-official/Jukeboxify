import 'package:dartz/dartz.dart';
import 'package:jukeboxify/other/error/failures.dart';
import 'package:jukeboxify/features/spotify/domain/entities/spotify_user_entity.dart';

abstract class SpotifyRepo {
  Future<Either<Failure, SpotifyUserEntity>> getSpotifyUser();
}
