import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jukeboxify/features/spotify/presentation/bloc/spotify_auth/spotify_auth_bloc.dart';
import 'package:jukeboxify/features/spotify/presentation/widgets/spotify_user_info.dart';
import 'package:mockito/mockito.dart';

class MockSpotifyAuthBloc extends MockBloc<SpotifyAuthState>
    implements SpotifyAuthBloc {}

class TestApp extends StatelessWidget {
  final SpotifyAuthBloc spotifyAuthBloc;
  final SpotifyUserInfoListItem targetWidget;

  const TestApp({@required this.spotifyAuthBloc, @required this.targetWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => spotifyAuthBloc,
        child: MaterialApp(home: targetWidget));
  }
}

void main() {
  SpotifyUserInfoListItem targetWidget = SpotifyUserInfoListItem();
  MockSpotifyAuthBloc spotifyAuthBloc;
  Widget testApp;

  setUp(() {
    spotifyAuthBloc = MockSpotifyAuthBloc();
    testApp =
        TestApp(spotifyAuthBloc: spotifyAuthBloc, targetWidget: targetWidget);
  });

  tearDown(() {
    spotifyAuthBloc.close();
  });

  group('SpotifyUserInfo', () {
    testWidgets('handles not-loaded state correctly',
        (WidgetTester tester) async {
      final notLoaded = find.byKey(targetWidget.keys["not-loaded"]);
      when(spotifyAuthBloc.state).thenAnswer((_) => SpotifyAuthState.loading);
      await tester.pumpWidget(testApp);
      expect(notLoaded, findsOneWidget);
    });

    testWidgets('handles loaded state correctly', (WidgetTester tester) async {
      final loaded = find.byKey(targetWidget.keys["loaded"]);
      when(spotifyAuthBloc.state).thenAnswer((_) => SpotifyAuthState.success);
      await tester.pumpWidget(testApp);
      expect(loaded, findsOneWidget);
    });

    testWidgets('handles error state correctly', (WidgetTester tester) async {
      final error = find.byKey(targetWidget.keys["error"]);
      when(spotifyAuthBloc.state).thenAnswer((_) => SpotifyAuthState.failure);
      await tester.pumpWidget(testApp);
      expect(error, findsOneWidget);
    });
  });
}
