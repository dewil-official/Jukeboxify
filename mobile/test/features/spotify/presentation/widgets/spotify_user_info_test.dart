import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
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

  testWidgets('SpotifyUserInfo shows Login Button & NotLoadedText',
      (WidgetTester tester) async {
    await tester.pumpWidget(testApp);
    // prepare finders
    final notLoaded = find.byKey(targetWidget.keys["not-loaded"]);
    final infoWidget = find.byType(SpotifyUserInfoListItem);
    // Bloc Mock - Initial state
    when(spotifyBloc.state).thenAnswer((_) => SpotifyInitial());
    // assert
    expect(infoWidget, findsOneWidget);
    expect(notLoaded, findsOneWidget);
  });
}
