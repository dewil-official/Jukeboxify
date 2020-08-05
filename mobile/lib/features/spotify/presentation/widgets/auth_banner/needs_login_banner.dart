import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jukeboxify/features/spotify/presentation/bloc/spotify_auth/spotify_auth_bloc.dart';

class NeedsLoginBanner extends StatelessWidget {
  final Key key;

  NeedsLoginBanner({this.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Spotify isn\'t loaded.'),
      subtitle: Text('Click the button to load Spotify.'),
      trailing: RaisedButton.icon(
          onPressed: () => {
                BlocProvider.of<SpotifyAuthBloc>(context)
                    .add(SpotifyAuthEvent.loginUser)
              },
          icon: Icon(Icons.transit_enterexit),
          label: Text('Login/Load')),
    );
  }
}
