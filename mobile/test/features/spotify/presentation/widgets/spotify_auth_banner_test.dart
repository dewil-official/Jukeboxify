import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jukeboxify/features/spotify/presentation/bloc/spotify_auth/spotify_auth_bloc.dart';
import 'package:jukeboxify/features/spotify/presentation/widgets/spotify_auth_banner.dart';
import 'package:mockito/mockito.dart';

class MockSpotifyAuthBloc extends MockBloc<SpotifyAuthState>
    implements SpotifyAuthBloc {}

class TestApp extends StatelessWidget {
  final SpotifyAuthBloc spotifyAuthBloc;
  final SpotifyAuthBanner targetWidget;

  const TestApp({@required this.spotifyAuthBloc, @required this.targetWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => spotifyAuthBloc,
        child: MaterialApp(home: targetWidget));
  }
}

void main() {
  SpotifyAuthBanner targetWidget = SpotifyAuthBanner();
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

  group('SpotifyAuthBanner', () {
    testWidgets('displays the LoadingBanner on initialState',
        (WidgetTester tester) async {
      final loadingBanner = find.byKey(ValueKey(SpotifyAuthState.initializing));
      when(spotifyAuthBloc.state).thenAnswer((_) => SpotifyAuthState.initial);
      await tester.pumpWidget(testApp);
      expect(loadingBanner, findsOneWidget);
    });
    testWidgets('displays the LoadingBanner on initializingState',
        (WidgetTester tester) async {
      final loadingBanner = find.byKey(ValueKey(SpotifyAuthState.initializing));
      when(spotifyAuthBloc.state)
          .thenAnswer((_) => SpotifyAuthState.initializing);
      await tester.pumpWidget(testApp);
      expect(loadingBanner, findsOneWidget);
    });
    testWidgets('displays the LoadingBanner on checkingTokenState',
        (WidgetTester tester) async {
      final loadingBanner = find.byKey(ValueKey(SpotifyAuthState.initializing));
      when(spotifyAuthBloc.state)
          .thenAnswer((_) => SpotifyAuthState.checksToken);
      await tester.pumpWidget(testApp);
      expect(loadingBanner, findsOneWidget);
    });
    testWidgets('displays the NeedsLoginBanner on needsLogin',
        (WidgetTester tester) async {
      final loadingBanner = find.byKey(ValueKey(SpotifyAuthState.needsLogin));
      when(spotifyAuthBloc.state)
          .thenAnswer((_) => SpotifyAuthState.needsLogin);
      await tester.pumpWidget(testApp);
      expect(loadingBanner, findsOneWidget);
    });
    testWidgets('displays the SuccessBanner', (WidgetTester tester) async {
      final loadingBanner = find.byKey(ValueKey(SpotifyAuthState.success));
      when(spotifyAuthBloc.state).thenAnswer((_) => SpotifyAuthState.success);
      await tester.pumpWidget(testApp);
      expect(loadingBanner, findsOneWidget);
    });
    testWidgets('displays the FailureBanner on initialState',
        (WidgetTester tester) async {
      final loadingBanner = find.byKey(ValueKey(SpotifyAuthState.failure));
      when(spotifyAuthBloc.state).thenAnswer((_) => SpotifyAuthState.failure);
      await tester.pumpWidget(testApp);
      expect(loadingBanner, findsOneWidget);
    });
  });
}
