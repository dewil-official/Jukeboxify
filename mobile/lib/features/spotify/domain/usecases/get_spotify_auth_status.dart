import 'package:injectable/injectable.dart';
import 'package:jukeboxify/features/spotify/domain/repositories/spotify_repo.dart';
import 'package:meta/meta.dart';
import 'package:jukeboxify/features/spotify/domain/entities/spotify_auth_status.dart';
import 'package:jukeboxify/other/usecases/usecase.dart';

@Environment(Environment.dev)
@singleton
class GetSpotifyAuthStatus extends UseCase<SpotifyAuthStatus, NoParams> {
  final SpotifyRepo spotifyRepo;

  GetSpotifyAuthStatus({@required this.spotifyRepo});

  @override
  Future<SpotifyAuthStatus> call(NoParams params) {
    throw UnimplementedError();
  }
}
