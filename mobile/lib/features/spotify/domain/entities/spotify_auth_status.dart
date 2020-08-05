import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SpotifyAuthStatus extends Equatable {
  final bool isLoggedIn;

  SpotifyAuthStatus({@required this.isLoggedIn});

  @override
  List<Object> get props => [isLoggedIn];
}
