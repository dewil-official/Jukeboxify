import 'package:dartz/dartz.dart';
import 'package:jukeboxify/core/error/failures.dart';
import 'package:jukeboxify/core/usecases/usecase.dart';
import 'package:jukeboxify/features/spotify/domain/entities/spotify_user_entity.dart';
import 'package:jukeboxify/features/spotify/domain/repositories/spotify_api_repository.dart';
import 'package:jukeboxify/features/spotify/domain/repositories/spotify_auth_repository.dart';

import 'package:meta/meta.dart';

class LoginToSpotify extends UseCase<SpotifyUserEntity, NoParams> {
  SpotifyApiRepository apiRepo;
  SpotifyAuthRepository authRepo;

  LoginToSpotify({@required this.apiRepo, @required this.authRepo});

  @override
  Future<Either<Failure, SpotifyUserEntity>> call(NoParams _) async {
    Either<Failure, SpotifyUserEntity> result;
    if (await authRepo.hasToken()) {
      if (!await authRepo.isTokenExpired()) {
        result = await apiRepo.getSpotifyUser(await authRepo.getToken());
        return result;
      } else {
        await authRepo.refreshToken();
        result = await apiRepo.getSpotifyUser(await authRepo.getToken());
        return result;
      }
    } else {
      await authRepo.promptLogin();
      result = await apiRepo.getSpotifyUser(await authRepo.getToken());
      return result;
    }
  }
}
