import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jukeboxify/core/injection/injection.dart';
import 'package:jukeboxify/features/main/presentation/pages/home_page.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';

import 'features/spotify/presentation/bloc/spotify/spotify_bloc.dart';

void main() {
  configureInjection(Environment(Environment.dev));
  runApp(JukeboxifyApp());
}

class JukeboxifyApp extends StatelessWidget {
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
