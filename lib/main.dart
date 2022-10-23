import 'package:ada_bread/data_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'front_screen.dart';
import 'house_screen/house_model.dart';

void main() {
  runApp(const SOSProject());
}

class SOSProject extends StatelessWidget {
  const SOSProject({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => DataStorage(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => HouseData(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FrontScreen(),
      ),
    );
  }
}
