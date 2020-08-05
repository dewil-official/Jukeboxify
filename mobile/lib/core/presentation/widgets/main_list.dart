import 'package:flutter/material.dart';
import 'package:jukeboxify/features/spotify/presentation/widgets/spotify_auth_banner.dart';

class MainList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[SpotifyAuthBanner()],
    );
  }
}
