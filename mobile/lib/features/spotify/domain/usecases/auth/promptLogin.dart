import 'package:injectable/injectable.dart';
import 'package:jukeboxify/features/spotify/domain/repositories/spotify_repo.dart';
import 'package:meta/meta.dart';
import 'package:jukeboxify/other/usecases/usecase.dart';

@Environment(Environment.dev)
@singleton
class PromptLogin extends UseCase<void, NoParams> {
  final SpotifyRepo spotifyRepo;

  PromptLogin({@required this.spotifyRepo});

  @override
  Future call(NoParams params) {
    return spotifyRepo.promptLogin();
  }
}
