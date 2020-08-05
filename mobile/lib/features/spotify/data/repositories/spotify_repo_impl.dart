import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jukeboxify/features/spotify/domain/entities/spotify_auth_status.dart';
import 'package:jukeboxify/other/error/exceptions.dart';
import 'package:jukeboxify/features/spotify/data/datasources/spotify_client.dart';
import 'package:meta/meta.dart';
import 'package:jukeboxify/other/error/failures.dart';
import 'package:jukeboxify/features/spotify/domain/entities/spotify_user_entity.dart';
import 'package:jukeboxify/features/spotify/domain/repositories/spotify_repo.dart';

@Environment(Environment.dev)
@Singleton(as: SpotifyRepo)
class SpotifyRepoImpl implements SpotifyRepo {
  final SpotifyClient spotifyClient;

  SpotifyRepoImpl({@required this.spotifyClient});

  @override
  Future<Either<Failure, SpotifyUserEntity>> getSpotifyUser() async {
    try {
      final spotifyUser = await spotifyClient.getSpotifyUser();
      return Right(spotifyUser);
    } on SpotifyServerException {
      return Left(
          SpotifyServerFailure(message: 'The Spotify Server didn\'t respond.'));
    }
  }

  @override
  Future<SpotifyAuthStatus> getSpotifyAuthStatus() async {
    final hasToken = await spotifyClient.hasValidAccessToken();
    return SpotifyAuthStatus(isLoggedIn: hasToken);
  }
}
