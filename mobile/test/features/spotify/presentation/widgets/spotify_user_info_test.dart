import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jukeboxify/other/error/failures.dart';
import 'package:jukeboxify/features/spotify/domain/entities/spotify_user_entity.dart';
import 'package:jukeboxify/features/spotify/presentation/bloc/spotify/spotify_bloc.dart';
import 'package:jukeboxify/features/spotify/presentation/widgets/spotify_user_info.dart';
import 'package:mockito/mockito.dart';

class MockSpotifyBloc extends MockBloc<SpotifyState> implements SpotifyBloc {}

class TestApp extends StatelessWidget {
  final SpotifyBloc spotifyBloc;
  final SpotifyUserInfoListItem targetWidget;

  const TestApp({@required this.spotifyBloc, @required this.targetWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => spotifyBloc,
        child: MaterialApp(home: targetWidget));
  }
}

void main() {
  SpotifyUserInfoListItem targetWidget = SpotifyUserInfoListItem();
  MockSpotifyBloc spotifyBloc;
  Widget testApp;

  setUp(() {
    spotifyBloc = MockSpotifyBloc();
    testApp = TestApp(spotifyBloc: spotifyBloc, targetWidget: targetWidget);
  });

  tearDown(() {
    spotifyBloc.close();
  });

  group('SpotifyUserInfo', () {
    testWidgets('handles not-loaded state correctly',
        (WidgetTester tester) async {
      final notLoaded = find.byKey(targetWidget.keys["not-loaded"]);
      when(spotifyBloc.state).thenAnswer((_) => SpotifyLoading());
      await tester.pumpWidget(testApp);
      expect(notLoaded, findsOneWidget);
    });

    testWidgets('handles loaded state correctly', (WidgetTester tester) async {
      final fakeUser = SpotifyUserEntity(displayName: 'Bob');
      final loaded = find.byKey(targetWidget.keys["loaded"]);
      when(spotifyBloc.state)
          .thenAnswer((_) => SpotifyLoaded(spotifyUser: fakeUser));
      await tester.pumpWidget(testApp);
      expect(loaded, findsOneWidget);
    });

    testWidgets('handles error state correctly', (WidgetTester tester) async {
      final error = find.byKey(targetWidget.keys["error"]);
      when(spotifyBloc.state).thenAnswer(
          (_) => SpotifyError(failure: SpotifyServerFailure(message: '')));
      await tester.pumpWidget(testApp);
      expect(error, findsOneWidget);
    });

    testWidgets('shows failure message', (WidgetTester tester) async {
      final errorMessage = "The server didn't respond.";
      final failure = SpotifyServerFailure(message: errorMessage);

      when(spotifyBloc.state).thenAnswer((_) => SpotifyError(failure: failure));
      final foundText = find.text(errorMessage);

      await tester.pumpWidget(testApp);
      expect(foundText, findsOneWidget);
    });
  });
}
