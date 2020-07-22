import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jukeboxify/core/error/exceptions.dart';
import 'package:jukeboxify/features/spotify/data/datasources/spotify_client.dart';
import 'package:meta/meta.dart';
import 'package:jukeboxify/core/error/failures.dart';
import 'package:jukeboxify/features/spotify/domain/entities/spotify_user_entity.dart';
import 'package:jukeboxify/features/spotify/domain/repositories/spotify_repo.dart';

@singleton
class SpotifyRepoImpl implements SpotifyRepo {
  final SpotifyClient spotifyClient;

  SpotifyRepoImpl({@required this.spotifyClient});

  @override
  Future<Either<Failure, SpotifyUserEntity>> getSpotifyUser() async {
    try {
      final spotifyUser = await spotifyClient.getSpotifyUser();
      return Right(spotifyUser);
    } on SpotifyServerException {
      return Left(SpotifyServerFailure());
    }
  }
}
