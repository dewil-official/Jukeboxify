import 'package:injectable/injectable.dart';
import 'package:jukeboxify/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:jukeboxify/core/usecases/usecase.dart';
import 'package:jukeboxify/features/spotify/domain/entities/spotify_user_entity.dart';
import 'package:jukeboxify/features/spotify/domain/repositories/spotify_repo.dart';
import 'package:meta/meta.dart';

@Environment(Environment.dev)
@singleton
class GetSpotifyProfile extends UseCase<SpotifyUserEntity, NoParams> {
  final SpotifyRepo spotifyRepo;

  GetSpotifyProfile({@required this.spotifyRepo});

  @override
  Future<Either<Failure, SpotifyUserEntity>> call(NoParams params) {
    return spotifyRepo.getSpotifyUser();
  }
}
