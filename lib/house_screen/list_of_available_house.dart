import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../crediential/data_provider.dart';
import 'house_detail.dart';

final _auth = FirebaseAuth.instance;
var loggedInUser;

class ListOfAvailableHouse extends StatefulWidget {
  ListOfAvailableHouse({this.type, this.houseType});
  String type;
  List houseType;

  @override
  State<ListOfAvailableHouse> createState() => _ListOfAvailableHouseState();
}

class _ListOfAvailableHouseState extends State<ListOfAvailableHouse> {
  NumberFormat numberFormat = NumberFormat.decimalPattern('en_us');

  @override
  void initState() {
    getCurrentUser();
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      setState(() {});
    });
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user.uid;
      }
    } catch (e) {
      print(e);
    }
  }

  bool _isLiked = false;
  String currentUserID = '';
  String currentUser = '';
  String currentUserName = '';
  String currentProfilePic = '';
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;

    int columnCount = 3;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(40, 53, 147, 1),
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('HomeDetail').snapshots(),
        builder: (context, snapData) {
          if (!snapData.hasData) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/no-data.png',
                  width: 150,
                ),
                const Text(
                  'No Data Entry',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                  ),
                )
              ],
            ));
          }
          final userFavItems =
              Provider.of<DataProvider>(context).registeredMembers;
          final userFavoriteList =
              Provider.of<DataProvider>(context).registeredUserFavoriteItems;
          for (var message in userFavItems) {
            if (message['userID'] == loggedInUser) {
              currentUserID = message['userID'];
              currentUser = message['userEmail'];
              currentUserName = message['userFullName'];
              currentProfilePic = message['profilePic'];
            }
          }

          final houseType = snapData.data.docs;
          final typeFilter = houseType
              .where((element) => element['type'] == widget.type)
              .toList();
          return typeFilter.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('images/no-data.png'),
                      const Text('No data Entry!'),
                    ],
                  ),
                )
              : Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(40, 53, 147, 1),
                  ),
                  child: AnimationLimiter(
                    child: ListView.builder(
                      itemCount: typeFilter.length,
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      padding: EdgeInsets.all(_w / 60),
                      itemBuilder: (context, index) {
                        for (var message in userFavoriteList) {
                          if (currentUserID == loggedInUser &&
                              typeFilter[index]['itemID'] ==
                                  message['itemID']) {
                            _isLiked = message['isFavorite'];
                          }
                        }

                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          duration: const Duration(milliseconds: 500),
                          columnCount: columnCount,
                          child: ScaleAnimation(
                            duration: const Duration(milliseconds: 900),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: FadeInAnimation(
                              child: Container(
                                margin: EdgeInsets.only(
                                    bottom: _w / 30,
                                    left: _w / 60,
                                    right: _w / 60),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 40,
                                      spreadRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Container(
                                  height: _w * 0.35,
                                  color: Colors.white,
                                  margin: const EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: ClipRRect(
                                          child: Image.asset(
                                            typeFilter[index]['image'],
                                            fit: BoxFit.contain,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          clipBehavior: Clip.antiAlias,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              typeFilter[index]['title'],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 20),
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                    Icons.location_on_outlined),
                                                Text(
                                                  typeFilter[index]['location'],
                                                  style: const TextStyle(
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: const [
                                                Icon(
                                                  Icons.star_rate_rounded,
                                                  color: Colors.amber,
                                                ),
                                                Text(
                                                  '4.5 ',
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                Text(
                                                  ' (485 Reviews)',
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                MaterialButton(
                                                  color: Colors.blue[800],
                                                  elevation: 20,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    side: BorderSide(
                                                        color:
                                                            Colors.blue[800]),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (ctx) =>
                                                            HouseDetail(
                                                          houseID:
                                                              currentUserID,
                                                          houseIndex: index,
                                                          itemID:
                                                              typeFilter[index]
                                                                  ['itemID'],
                                                          itemType:
                                                              typeFilter[index]
                                                                  ['itemType'],
                                                          image:
                                                              typeFilter[index]
                                                                  ['image'],
                                                          description:
                                                              typeFilter[index][
                                                                  'description'],
                                                          title:
                                                              typeFilter[index]
                                                                  ['title'],
                                                          area:
                                                              typeFilter[index]
                                                                  ['area'],
                                                          facility:
                                                              typeFilter[index]
                                                                  ['facility'],
                                                          type:
                                                              typeFilter[index]
                                                                  ['type'],
                                                          price: numberFormat
                                                              .format(
                                                                  typeFilter[
                                                                          index]
                                                                      ['price'])
                                                              .toString(),
                                                          location:
                                                              typeFilter[index]
                                                                  ['location'],
                                                          isFavorite:
                                                              typeFilter[index][
                                                                  'isFavorite'],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: const Text(
                                                    'Detail',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                MaterialButton(
                                                  shape: const CircleBorder(),
                                                  elevation: 15,
                                                  color: Colors.white,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: Icon(
                                                      _isLiked
                                                          ? Icons.favorite
                                                          : Icons
                                                              .favorite_border,
                                                      color: Colors.pink[800],
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    setState(() {
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'Favorite')
                                                          .doc(typeFilter[index]
                                                                  ['itemID'] +
                                                              typeFilter[index]
                                                                  ['userID'])
                                                          .set({
                                                        'userID': currentUserID,
                                                        'itemID':
                                                            typeFilter[index]
                                                                ['itemID'],
                                                        'itemType':
                                                            typeFilter[index]
                                                                ['itemType'],
                                                        'image':
                                                            typeFilter[index]
                                                                ['image'],
                                                        'description':
                                                            typeFilter[index]
                                                                ['description'],
                                                        'title':
                                                            typeFilter[index]
                                                                ['title'],
                                                        'area':
                                                            typeFilter[index]
                                                                ['area'],
                                                        'facility':
                                                            typeFilter[index]
                                                                ['facility'],
                                                        'type':
                                                            typeFilter[index]
                                                                ['type'],
                                                        'price':
                                                            typeFilter[index]
                                                                ['price'],
                                                        'location':
                                                            typeFilter[index]
                                                                ['location'],
                                                        'isFavorite': !_isLiked,
                                                      });
                                                    });
                                                  },
                                                ),
                                              ],
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
        },
      ),
    );
  }
}
