import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        ],
        child: MaterialApp(
            title: 'Jukeboxify',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: HomePage()));
  }
}
