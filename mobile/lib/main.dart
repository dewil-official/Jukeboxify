import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jukeboxify/core/injection/injection.dart';
import 'package:jukeboxify/features/main/presentation/pages/home_page.dart';

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
