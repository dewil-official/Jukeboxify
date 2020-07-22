// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/get_it_helper.dart';
import 'package:oauth2_client/oauth2_helper.dart';

import '../../features/spotify/data/datasources/spotify_client.dart';
import '../../features/spotify/data/repositories/spotify_repo_impl.dart';
import '../../features/spotify/domain/repositories/spotify_repo.dart';
import '../../features/spotify/domain/usecases/get_spotify_profile.dart';
import '../../features/spotify/presentation/bloc/spotify/spotify_bloc.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

void $initGetIt(GetIt g, {String environment}) {
  final gh = GetItHelper(g, environment);

  // Eager singletons must be registered in the right order
  gh.singleton<GetSpotifyProfile>(
      GetSpotifyProfile(spotifyRepo: g<SpotifyRepo>()));
  gh.singleton<SpotifyBloc>(
      SpotifyBloc(getSpotifyProfile: g<GetSpotifyProfile>()));
  gh.singleton<SpotifyClient>(SpotifyClient(oAuth2Helper: g<OAuth2Helper>()));
  gh.singleton<SpotifyRepoImpl>(
      SpotifyRepoImpl(spotifyClient: g<SpotifyClient>()));
}
