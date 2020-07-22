import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jukeboxify/core/injection/injection.dart';
import 'package:jukeboxify/features/main/presentation/pages/home_page.dart';
import 'package:jukeboxify/features/spotify/data/datasources/spotify_client.dart';
import 'package:jukeboxify/features/spotify/data/repositories/spotify_repo_impl.dart';
import 'package:jukeboxify/features/spotify/domain/usecases/get_spotify_profile.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';

import 'features/spotify/presentation/bloc/spotify/spotify_bloc.dart';

void main() {
  configureInjection(Env.dev);
  runApp(JukeboxifyApp());
}

class JukeboxifyApp extends StatelessWidget {
  OAuth2Client oAuth2Client;
  OAuth2Helper oAuth2Helper;

  JukeboxifyApp() {
    oAuth2Client = OAuth2Client(
        authorizeUrl: 'https://accounts.spotify.com/authorize',
        tokenUrl: 'https://accounts.spotify.com/api/token',
        redirectUri: 'app.jukeboxify.mobile://oauth2redirect',
        customUriScheme: 'app.jukeboxify.mobile');
    oAuth2Helper = OAuth2Helper(oAuth2Client,
        grantType: OAuth2Helper.AUTHORIZATION_CODE,
        clientId: '0f883a103e00477e8a03b145ef8157ab',
        scopes: ['user-modify-playback-state']);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<SpotifyBloc>(
              create: (BuildContext context) => getIt.get<SpotifyBloc>()
              // TODO: Remove this when it works!
/*            create: (BuildContext context) => SpotifyBloc(
                getSpotifyProfile: GetSpotifyProfile(
                    spotifyRepo: SpotifyRepoImpl(
                        spotifyClient:
                            SpotifyClient(oAuth2Helper: oAuth2Helper)))),*/
              ),
        ],
        child: MaterialApp(
            title: 'Jukeboxify',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: HomePage()));
  }
}
