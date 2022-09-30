import 'package:ada_bread/front_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const SOSProject());
}

class SOSProject extends StatelessWidget {
  const SOSProject({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FrontScreen(),
    );
  }
}
