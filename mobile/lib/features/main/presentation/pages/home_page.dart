import 'package:flutter/material.dart';
import 'package:jukeboxify/features/main/presentation/widgets/main_list.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: MainList(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text('Jukeboxify'),
    );
  }
}
