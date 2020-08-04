import 'package:flutter/material.dart';
import 'package:jukeboxify/features/spotify/presentation/widgets/spotify_user_info.dart';

class MainList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[SpotifyUserInfoListItem()],
    );
  }
}
