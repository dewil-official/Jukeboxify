// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/get_it_helper.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';

import '../../features/spotify/data/datasources/spotify_client.dart';
import '../../features/spotify/data/repositories/spotify_repo_impl.dart';
import '../../features/spotify/domain/repositories/spotify_repo.dart';
import '../../features/spotify/domain/usecases/get_spotify_profile.dart';
import '../../features/spotify/presentation/bloc/spotify/spotify_bloc.dart';

/// Environment names
const _dev = 'dev';

/// adds generated dependencies
/// to the provided [GetIt] instance

void $initGetIt(GetIt g, {String environment}) {
  final gh = GetItHelper(g, environment);
  final registerModule = _$RegisterModule();
  gh.factory<OAuth2Client>(() => registerModule.oAuth2Client,
      instanceName: 'OAuth2Client');

  // Eager singletons must be registered in the right order
  gh.singleton<OAuth2Helper>(registerModule
      .oAuth2Helper(g<OAuth2Client>(instanceName: 'OAuth2Client')));
  gh.singleton<SpotifyClient>(SpotifyClient(oAuth2Helper: g<OAuth2Helper>()),
      registerFor: {_dev});
  gh.singleton<SpotifyRepo>(SpotifyRepoImpl(spotifyClient: g<SpotifyClient>()),
      registerFor: {_dev});
  gh.singleton<GetSpotifyProfile>(
      GetSpotifyProfile(spotifyRepo: g<SpotifyRepo>()),
      registerFor: {_dev});
  gh.singleton<SpotifyBloc>(
      SpotifyBloc(getSpotifyProfile: g<GetSpotifyProfile>()),
      registerFor: {_dev});
}

class _$RegisterModule extends RegisterModule {}
