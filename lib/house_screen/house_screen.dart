import 'package:ada_bread/buttons/search_button.dart';
import 'package:flutter/material.dart';

import 'choice_of_items.dart';
import 'list_of_item.dart';

class HouseScreen extends StatelessWidget {
  const HouseScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    int columnCount = 2;
    int columnCountForMain = 3;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 110,
        actions: const [
          SearchButton(),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: Column(
            children: [
              ChoiceOfItems(columnCount: columnCount, w: _w),
              ListOfItems(
                  w: _w,
                  columnCountForMain: columnCountForMain,
                  columnCount: columnCount),
            ],
          ),
        ),
      ),
    );
  }
}
