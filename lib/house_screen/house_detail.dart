import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../collection_methods.dart';
import '../crediential/data_provider.dart';

final _auth = FirebaseAuth.instance;
NumberFormat numberGrouper = NumberFormat.decimalPattern('en_us');
var loggedInUser;

class HouseDetail extends StatefulWidget {
  HouseDetail(
      {@required this.price,
      @required this.type,
      @required this.image,
      @required this.location,
      @required this.isFavorite,
      @required this.facility,
      @required this.itemID,
      @required this.itemType,
      @required this.area,
      @required this.title,
      @required this.houseIndex,
      @required this.description,
      @required this.houseID});
  String title;
  int houseIndex;
  String houseID;
  String description;
  String itemType;
  String itemID;
  String area;
  String type;
  String price;
  String image;
  Map facility;
  String location;
  bool isFavorite;
  @override
  State<HouseDetail> createState() => _HouseDetailState();
}

class _HouseDetailState extends State<HouseDetail> {
  bool _onClick = false;
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
  String dateTime = DateTime.now().toString();
  String currentUserID;
  void datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      firstDate: DateTime(DateTime.now().month + 1),
    ).then(
      (value) => setState(
        () {
          if (value != null) {
            dateTime = value.toString();
          } else {
            dateTime = DateTime.now().toString();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    int columnCount = 1;

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('HomeDetail').snapshots(),
        builder: (context, detailSnap) {
          if (!detailSnap.hasData) {
            return const Center(
              child: Text('Loading...'),
            );
          }
          final userFavItems =
              Provider.of<DataProvider>(context).registeredMembers;

          for (var message in userFavItems) {
            if (message['userID'] == loggedInUser) {
              currentUserID = message['userID'];
            }
          }
          final userFavoriteLists =
              Provider.of<DataProvider>(context).registeredUserFavoriteItems;
          final detailSnapData = detailSnap.data.docs;
          for (var message in userFavoriteLists) {
            if (message['userID'] == loggedInUser &&
                detailSnapData[widget.houseIndex]['itemID'] ==
                    message['itemID']) {
              _isLiked = message['isFavorite'];
            } else if (message.isEmpty) {
              _isLiked = detailSnapData[widget.houseIndex]['isFavorite'];
            }
          }
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromRGBO(40, 53, 147, 1),
                      const Color.fromRGBO(40, 53, 147, 1).withOpacity(0.9)
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 4,
                      offset: const Offset(4, 8), // changes position of shadow
                    ),
                  ],
                ),
                child: AnimationLimiter(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: AnimationConfiguration.staggeredGrid(
                          position: 0,
                          duration: const Duration(milliseconds: 500),
                          columnCount: columnCount,
                          child: ScaleAnimation(
                            duration: const Duration(milliseconds: 900),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: FadeInAnimation(
                              child: Container(
                                child: ClipRRect(
                                  child: Image.asset(
                                    detailSnapData[widget.houseIndex]['image'],
                                    fit: BoxFit.contain,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  clipBehavior: Clip.antiAlias,
                                ),
                                margin: EdgeInsets.only(
                                    left: _w / 60, right: _w / 60),
                                //clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 40,
                                      spreadRadius: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: AnimationConfiguration.staggeredGrid(
                          position: 0,
                          duration: const Duration(milliseconds: 500),
                          columnCount: columnCount,
                          child: ScaleAnimation(
                            duration: const Duration(milliseconds: 900),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: FadeInAnimation(
                              child: Container(
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                18.0, 10, 0, 15),
                                            child: Text(
                                              detailSnapData[widget.houseIndex]
                                                  ['title'],
                                              style: const TextStyle(
                                                decoration: TextDecoration.none,
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.location_on_outlined,
                                                size: 25,
                                              ),
                                              Text(
                                                detailSnapData[widget
                                                    .houseIndex]['location'],
                                                style: const TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontSize: 18,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child:
                                          AnimationConfiguration.staggeredGrid(
                                        position: 0,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        columnCount: columnCount,
                                        child: ScaleAnimation(
                                          duration:
                                              const Duration(milliseconds: 900),
                                          curve: Curves.fastLinearToSlowEaseIn,
                                          child: FadeInAnimation(
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.93,
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  17, 0, 8, 8),
                                                          child: ListView(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Image.asset(
                                                                    'images/double-bed.png',
                                                                    width: 20,
                                                                  ),
                                                                  Container(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left: 8,
                                                                        right:
                                                                            8),
                                                                    child: Text(
                                                                      '${detailSnapData[widget.houseIndex]['facility']['beds']} beds',
                                                                      style:
                                                                          const TextStyle(
                                                                        decoration:
                                                                            TextDecoration.none,
                                                                        fontSize:
                                                                            18,
                                                                        color: Colors
                                                                            .grey,
                                                                        fontWeight:
                                                                            FontWeight.w900,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Image.asset(
                                                                    'images/bath.png',
                                                                    width: 20,
                                                                  ),
                                                                  Container(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left: 8,
                                                                        right:
                                                                            8),
                                                                    child: Text(
                                                                      '${detailSnapData[widget.houseIndex]['facility']['bath']} bath',
                                                                      style:
                                                                          const TextStyle(
                                                                        decoration:
                                                                            TextDecoration.none,
                                                                        fontSize:
                                                                            18,
                                                                        color: Colors
                                                                            .grey,
                                                                        fontWeight:
                                                                            FontWeight.w900,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Image.asset(
                                                                    'images/parking-sign.png',
                                                                    width: 20,
                                                                  ),
                                                                  Container(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left: 8,
                                                                        right:
                                                                            8),
                                                                    child: Text(
                                                                      '${detailSnapData[widget.houseIndex]['facility']['parking']} parking',
                                                                      style:
                                                                          const TextStyle(
                                                                        decoration:
                                                                            TextDecoration.none,
                                                                        fontSize:
                                                                            18,
                                                                        color: Colors
                                                                            .grey,
                                                                        fontWeight:
                                                                            FontWeight.w900,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Image.asset(
                                                                    'images/area.png',
                                                                    width: 20,
                                                                  ),
                                                                  Container(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left: 8,
                                                                        right:
                                                                            8),
                                                                    child: Text(
                                                                      '${detailSnapData[widget.houseIndex]['facility']['area']}',
                                                                      style:
                                                                          const TextStyle(
                                                                        decoration:
                                                                            TextDecoration.none,
                                                                        fontSize:
                                                                            18,
                                                                        color: Colors
                                                                            .grey,
                                                                        fontWeight:
                                                                            FontWeight.w900,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              margin: EdgeInsets.only(
                                                  bottom: _w / 10,
                                                  left: _w / 60,
                                                  right: _w / 60),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    blurRadius: 40,
                                                    spreadRadius: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text(
                                          detailSnapData[widget.houseIndex]
                                              ['description'],
                                          softWrap: true,
                                          textAlign: TextAlign.justify,
                                          maxLines: 5,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                margin: EdgeInsets.only(
                                    //  top: _w / 20,
                                    bottom: _w / 20,
                                    left: _w / 60,
                                    right: _w / 60),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 40,
                                      spreadRadius: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 50,
                right: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        buyingProcess(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(35, 10, 10, 0),
                        width: 80,
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: Colors.blue[500],
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          datePicker();
                          _onClick = !_onClick;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(5, 10, 10, 0),
                        width: 220,
                        height: 60.0,
                        decoration: BoxDecoration(
                          color: Colors.blue[500],
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Center(
                          child: _onClick
                              ? Text(
                                  '${DateFormat.yMEd().format(DateTime.parse(dateTime))},',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18),
                                )
                              : const Text(
                                  'Book Now',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: _w * 0.15,
                right: 0,
                child: MaterialButton(
                  shape: const CircleBorder(),
                  elevation: 15,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Icon(
                      _isLiked ? Icons.favorite : Icons.favorite_border,
                      color: Colors.pink[800],
                    ),
                  ),
                  onPressed: () async {
                    setState(() {
                      final houseID =
                          Provider.of<DataProvider>(context, listen: false)
                              .houseV4Crypto;
                      FirebaseFirestore.instance
                          .collection('Favorite')
                          .doc(detailSnapData[widget.houseIndex]['itemID'] +
                              currentUserID)
                          .set({
                        'userID': currentUserID,
                        'image': widget.image,
                        'itemType': widget.itemType,
                        'itemID': widget.itemID,
                        'description': widget.description,
                        'title': widget.title,
                        'area': widget.area,
                        'facility': widget.facility,
                        'type': widget.type,
                        'price': widget.price,
                        'location': widget.location,
                        'isFavorite': !_isLiked,
                      });
                    });
                  },
                ),
              ),
              Positioned(
                top: 50,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_sharp,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
