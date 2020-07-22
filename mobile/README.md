# Jukeboxify

The idea is to use NFC tags in order to start Songs on Spotify.

This App will:

- Write song / playlist IDs to NFC tags
- Start the song / playlist upon scanning the NFC tag
- Manage the stored IDs & their Spotify counterparts
- (Later sync with a Raspberry Pi)

## Development

- Run `flutter run` to start the App on a device
- Run `flutter pub run build_runner watch --delete-conflicting-outputs` to start the `injectable` scanner that converts dependency injection annotations to the `injection.config.dart` file.
- I recommend binding `dart.runAllTestsWithoutDebugging` to a keyboard shortcut in your IDE.
