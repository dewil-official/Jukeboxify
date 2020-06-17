import 'package:flutter/material.dart';

void main() {
  runApp(JukeboxifyApp());
}

class JukeboxifyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jukeboxify',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Center(
        child: Text('WIP.'),
      ),
    );
  }
}
