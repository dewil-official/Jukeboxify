import 'dart:io';

String fixture(String name) =>
    File('test/fixtures/spotify/$name').readAsStringSync();
