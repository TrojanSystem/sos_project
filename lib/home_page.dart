import 'package:ada_bread/car_screen/car_home_page.dart';
import 'package:ada_bread/house_screen/house_screen.dart';
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
              Image.asset(
                'images/home (1).png',
                width: 30,
              ),
              Image.asset(
                'images/steering-wheel.png',
                width: 30,
              ),
              Image.asset(
                'images/auction.png',
                width: 30,
              ),
              Image.asset(
                'images/news.png',
                width: 30,
              ),
            ],
          ),
        ),
        body: TabBarView(
          physics: const BouncingScrollPhysics(),
          dragStartBehavior: DragStartBehavior.down,
          children: [
            const HouseScreen(),
            const CarHomeScreen(),
            Container(
              color: Colors.grey[200],
              child: const Center(
                child: Text(
                  'Tender Screen',
                  style: TextStyle(fontSize: 50),
                ),
              ),
            ),
            NewsScreen(),
          ],
        ),
        drawer: const CustomDrawer(),
      ),
    );
  }
}
