import 'package:ada_bread/buttons/search_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'choice_of_items.dart';
import 'list_of_item.dart';

class HouseScreen extends StatefulWidget {
  const HouseScreen({Key key}) : super(key: key);

  @override
  State<HouseScreen> createState() => _HouseScreenState();
}

class _HouseScreenState extends State<HouseScreen> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'Are you sure?',
              style: TextStyle(color: Colors.white),
            ),
            content: const Text(
              'Do you want to exit an App',
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(false), //<-- SEE HERE
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.of(context).pop(true), // <-- SEE HERE
                child: const Text('Yes'),
              ),
            ],
            backgroundColor: Colors.black.withOpacity(0.3),
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    int columnCount = 2;
    int columnCountForMain = 3;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 110,
          actions: [
            SearchButton(),
          ],
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('HomeDetail').snapshots(),
            builder: (context, homeData) {
              if (!homeData.hasData) {
                return Center(
                  child: Center(
                    child: SpinKitWave(
                      color: Colors.blue[800],
                      size: 80.0,
                      itemCount: 5,
                    ),
                  ),
                );
              }
              final detailHouseData = homeData.data.docs;
              return SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.72,
                  child: Column(
                    children: [
                      ChoiceOfItems(
                        columnCount: columnCount,
                        w: _w,
                        typeFilter: detailHouseData,
                      ),
                      ListOfItems(
                        w: _w,
                        columnCountForMain: columnCountForMain,
                        columnCount: columnCount,
                        listOfHouse: detailHouseData,
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
