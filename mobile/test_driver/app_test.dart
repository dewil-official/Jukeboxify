// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Jukeboxify Mobile App', () {
    final loginButtonFinder = find.byValueKey('SpotifyLoginButton');

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    // At least I'd know, when the test fail because of test driver availability
    test('check flutter driver health', () async {
      final health = await driver.checkHealth();
      expect(health.status, HealthStatus.ok);
    });

    test('shows Spotify Login Button after Loading', () async {
      try {
        await driver.waitFor(loginButtonFinder, timeout: Duration(seconds: 2));
        expect(true, true);
      } on DriverError {
        expect("Should find LoginButton within given timeout", true);
      }
    });

    test('increments the counter', () async {
      await driver.tap(loginButtonFinder);
      await Future.delayed(Duration(seconds: 5));
      // How to test for CustomChromeTabs?
    });
  });
}
