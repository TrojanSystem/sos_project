import 'package:ada_bread/car_screen/car_home_page.dart';
import 'package:ada_bread/house_screen/house_screen.dart';
import 'package:ada_bread/tender_screen/tender_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'drawer/custom_drawer.dart';
import 'news_screen/news_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 35,
          bottom: TabBar(
            padding: const EdgeInsets.only(bottom: 5),
            indicatorColor: Colors.black,
            indicatorWeight: 3,
            tabs: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Image.asset(
                  'images/home (1).png',
                  width: 25,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Image.asset(
                  'images/steering-wheel.png',
                  width: 25,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Image.asset(
                  'images/auction.png',
                  width: 25,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Image.asset(
                  'images/news.png',
                  width: 25,
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          physics: BouncingScrollPhysics(),
          dragStartBehavior: DragStartBehavior.down,
          children: [
            HouseScreen(),
            CarHomeScreen(),
            TenderScreen(),
            NewsScreen(),
          ],
        ),
        drawer: const CustomDrawer(),
      ),
    );
  }
}
