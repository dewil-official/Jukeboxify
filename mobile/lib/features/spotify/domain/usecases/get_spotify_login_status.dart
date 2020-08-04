import 'package:injectable/injectable.dart';
import 'package:jukeboxify/features/spotify/domain/repositories/spotify_repo.dart';
import 'package:meta/meta.dart';
import 'package:jukeboxify/features/spotify/domain/entities/spotify_login_status.dart';
import 'package:jukeboxify/features/spotify/domain/entities/spotify_user_entity.dart';
import 'package:jukeboxify/other/usecases/usecase.dart';

@Environment(Environment.dev)
@singleton
class GetSpotifyLoginStatus extends UseCase<SpotifyLoginStatus, NoParams> {
  final SpotifyRepo spotifyRepo;

  GetSpotifyLoginStatus({@required this.spotifyRepo});

  @override
  Future<SpotifyLoginStatus> call(NoParams params) {
    throw UnimplementedError();
  }
}
