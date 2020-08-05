import 'package:flutter/material.dart';

class LoadingAuthBanner extends StatelessWidget {
  final Key key;

  LoadingAuthBanner({this.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Loading...'),
        Expanded(child: LinearProgressIndicator())
      ],
    );
  }
}
