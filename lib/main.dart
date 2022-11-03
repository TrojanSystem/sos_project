import 'package:ada_bread/data_storage.dart';
import 'package:ada_bread/front_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'car_screen/car_model.dart';
import 'crediential/data_provider.dart';
import 'house_screen/house_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        ChangeNotifierProvider(
          create: (ctx) => CarData(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => DataProvider()
            ..loadCarDetailDataList()
            ..loadFavoriteCarDataList()
            ..loadCarDataList()
            ..loadHomeDetailDataList(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FrontScreen(),
      ),
    );
  }
}
