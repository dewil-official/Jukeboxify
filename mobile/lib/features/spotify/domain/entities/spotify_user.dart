import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SpotifyUser extends Equatable {
  final String displayName;

  SpotifyUser({@required this.displayName});

  @override
  List<Object> get props => [displayName];
}
