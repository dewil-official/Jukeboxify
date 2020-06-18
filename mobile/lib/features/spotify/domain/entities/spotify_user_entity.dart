import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SpotifyUserEntity extends Equatable {
  final String displayName;

  SpotifyUserEntity({@required this.displayName});

  @override
  List<Object> get props => [displayName];
}
