import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:jukeboxify/core/error/failures.dart';
import 'package:jukeboxify/core/usecases/usecase.dart';
import 'package:jukeboxify/features/spotify/domain/entities/spotify_user_entity.dart';
import 'package:jukeboxify/features/spotify/domain/usecases/get_spotify_profile.dart';
import 'package:meta/meta.dart';

part 'spotify_event.dart';
part 'spotify_state.dart';

@singleton
class SpotifyBloc extends Bloc<SpotifyEvent, SpotifyState> {
  final GetSpotifyProfile getSpotifyProfile;

  SpotifyBloc({@required this.getSpotifyProfile})
      : assert(getSpotifyProfile != null),
        super(SpotifyInitial());

  @override
  Stream<SpotifyState> mapEventToState(
    SpotifyEvent event,
  ) async* {
    if (event is LoadUser) {
      final failureOrSpotifyUser = await getSpotifyProfile(NoParams());
      yield* failureOrSpotifyUser.fold((failure) async* {
        yield SpotifyError(failure: failure);
      }, (spotifyUser) async* {
        yield SpotifyLoaded(spotifyUser: spotifyUser);
      });
    } else {
      yield SpotifyError(failure: UnknownSpotifyFailure());
    }
  }
}
