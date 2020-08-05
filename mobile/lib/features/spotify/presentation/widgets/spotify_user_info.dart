import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jukeboxify/features/spotify/presentation/bloc/spotify/spotify_bloc.dart';

class SpotifyUserInfoListItem extends StatelessWidget {
  final keys = {
    "not-loaded": UniqueKey(),
    "loaded": UniqueKey(),
    "error": UniqueKey()
  };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpotifyBloc, SpotifyState>(builder: (context, state) {
      return Card(
          child: state is SpotifyLoading
              ? ListTile(
                  key: keys["not-loaded"],
                  title: Text('Spotify isn\'t loaded.'),
                  subtitle: Text('Click the button to load Spotify.'),
                  trailing: RaisedButton.icon(
                      onPressed: () => {
                            if (state is SpotifyLoaded)
                              {
                                print((state as SpotifyLoaded)
                                    .spotifyUser
                                    .toString())
                              },
                            BlocProvider.of<SpotifyBloc>(context)
                                .add(LoadUser()),
                          },
                      icon: Icon(Icons.transit_enterexit),
                      label: Text('Login/Load')),
                )
              : state is SpotifyLoaded
                  ? ListTile(
                      key: keys["loaded"],
                      title: Text('Welcome, ${state.spotifyUser.displayName}!'),
                      subtitle: Text('You can now start adding NFC tags!'),
                    )
                  : ListTile(
                      key: keys["error"],
                      title: Text('Sorry, something went wrong.'),
                      subtitle: Text((state as SpotifyError)?.failure?.message),
                    ));
    });
  }
}
