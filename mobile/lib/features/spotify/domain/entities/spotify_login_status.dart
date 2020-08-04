import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SpotifyLoginStatus extends Equatable {
  final bool isLoggedIn;

  SpotifyLoginStatus({@required this.isLoggedIn});

  @override
  List<Object> get props => [isLoggedIn];
}
