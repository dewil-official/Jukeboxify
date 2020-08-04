import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'app.dart';
import 'other/injection/injection.dart';

void main() {
  configureInjection(Environment(Environment.dev));
  runApp(JukeboxifyApp());
}
