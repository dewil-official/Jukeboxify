import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jukeboxify/features/spotify/presentation/bloc/spotify_auth/spotify_auth_bloc.dart';

import 'core/presentation/pages/home_page.dart';
import 'features/spotify/presentation/bloc/spotify/spotify_bloc.dart';
import 'other/injection/injection.dart';

class JukeboxifyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<SpotifyBloc>(
              create: (BuildContext context) => getIt.get<SpotifyBloc>()),
          BlocProvider<SpotifyAuthBloc>(create: (BuildContext context) {
            final bloc = getIt.get<SpotifyAuthBloc>();
            // Automatically load the SpotifyAuth on Startup.
            bloc.add(SpotifyAuthEvent.initialize);
            return bloc;
          }),
        ],
        child: MaterialApp(
            title: 'Jukeboxify',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: HomePage()));
  }
}
