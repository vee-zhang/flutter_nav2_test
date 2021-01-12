import 'package:flutter/material.dart';

///404页面，只展示，无任何交互
class UnknownRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('404!'),
      ),
    );
  }
}
