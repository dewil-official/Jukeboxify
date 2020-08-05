import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jukeboxify/features/spotify/presentation/bloc/spotify_auth/spotify_auth_bloc.dart';
import 'package:jukeboxify/features/spotify/presentation/widgets/auth_banner/loading_auth_banner.dart';
import 'package:jukeboxify/features/spotify/presentation/widgets/auth_banner/needs_login_banner.dart';

class SpotifyAuthBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(child: BlocBuilder<SpotifyAuthBloc, SpotifyAuthState>(
        builder: (context, state) {
      if (state == SpotifyAuthState.initial ||
          state == SpotifyAuthState.initializing ||
          state == SpotifyAuthState.checksToken) {
        return LoadingAuthBanner(key: ValueKey(SpotifyAuthState.initializing));
      }
      if (state == SpotifyAuthState.needsLogin) {
        return NeedsLoginBanner(key: ValueKey(SpotifyAuthState.needsLogin));
      }
      if (state == SpotifyAuthState.failure) {
        return ListTile(
          key: ValueKey(SpotifyAuthState.failure),
          title: Text('Sorry, something went wrong.'),
          subtitle: Text('Please login again.'),
        );
      }
      if (state == SpotifyAuthState.success) {
        return ListTile(
          key: ValueKey(SpotifyAuthState.success),
          title: Text('Welcome!'),
          subtitle: Text('You can now start adding NFC tags!'),
        );
      }
      return Container();
    }));
  }
}
