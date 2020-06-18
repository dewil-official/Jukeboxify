import 'package:jukeboxify/features/spotify/domain/entities/spotify_user_entity.dart';
import 'package:meta/meta.dart';

class SpotifyUserModel extends SpotifyUserEntity {
  SpotifyUserModel({@required String displayName})
      : super(displayName: displayName);

  factory SpotifyUserModel.fromJson(Map<String, dynamic> jsonData) {
    return SpotifyUserModel(displayName: jsonData['display_name']);
  }
}
