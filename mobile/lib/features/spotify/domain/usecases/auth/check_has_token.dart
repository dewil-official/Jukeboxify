import 'package:injectable/injectable.dart';
import 'package:jukeboxify/features/spotify/domain/repositories/spotify_repo.dart';
import 'package:meta/meta.dart';
import 'package:jukeboxify/other/usecases/usecase.dart';

@Environment(Environment.dev)
@singleton
class CheckHasToken extends UseCase<bool, NoParams> {
  final SpotifyRepo spotifyRepo;

  CheckHasToken({@required this.spotifyRepo});

  @override
  Future<bool> call(NoParams params) {
    return spotifyRepo.hasToken();
  }
}
