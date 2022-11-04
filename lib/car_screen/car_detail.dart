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
var loggedInUser;

class CarDetail extends StatefulWidget {
  CarDetail(
      {@required this.index,
      @required this.type,
      @required this.price,
      @required this.image,
      @required this.description,
      @required this.location,
      @required this.title,
      @required this.year,
      @required this.capacity,
      @required this.color,
      @required this.condition,
      @required this.exchangePossible,
      @required this.fuel,
      @required this.make,
      @required this.mileage,
      @required this.transmission,
      @required this.itemID,
      @required this.itemType,
      @required this.userID,
      @required this.isFavorite});
  String type,
      price,
      userID,
      itemType,
      itemID,
      image,
      description,
      location,
      title,
      year,
      capacity,
      color,
      condition,
      exchangePossible,
      fuel,
      make,
      mileage,
      transmission;
  int index;
  bool isFavorite;
  @override
  State<CarDetail> createState() => _CarDetailState();
}

class _CarDetailState extends State<CarDetail> {
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

  bool _onClick = false;

  String dateTime = DateTime.now().toString();

  void datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      firstDate: DateTime(DateTime.now().month + 1),
    ).then((value) => setState(() {
          if (value != null) {
            dateTime = value.toString();
          } else {
            dateTime = DateTime.now().toString();
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    int columnCount = 1;
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('CarModel').snapshots(),
            builder: (context, carModel) {
              if (!carModel.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final userFavItems =
                  Provider.of<DataProvider>(context).registeredMembers;
              final userFavoriteList = Provider.of<DataProvider>(context)
                  .registeredUserFavoriteItems;

              for (var message in userFavItems) {
                if (message['userID'] == loggedInUser) {
                  currentUserID = message['userID'];
                  currentUser = message['userEmail'];
                  currentUserName = message['userFullName'];
                  currentProfilePic = message['profilePic'];
                }
              }
              final carListDetail = carModel.data.docs;
              for (var message in userFavoriteList) {
                if (currentUserID == loggedInUser &&
                    carListDetail[widget.index]['itemID'] ==
                        message['itemID']) {
                  _isLiked = message['isFavorite'];
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
                          offset:
                              const Offset(4, 8), // changes position of shadow
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
                              columnCount: 1,
                              child: ScaleAnimation(
                                duration: const Duration(milliseconds: 900),
                                curve: Curves.fastLinearToSlowEaseIn,
                                child: FadeInAnimation(
                                  child: Container(
                                    child: Image.asset(
                                      carListDetail[widget.index]['image'],
                                      fit: BoxFit.contain,
                                    ),
                                    margin: EdgeInsets.only(
                                      bottom: _w / 60,
                                      top: _w / 10,
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
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
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        18.0, 8, 0, 15),
                                                child: Text(
                                                  carListDetail[widget.index]
                                                      ['title'],
                                                  style: const TextStyle(
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8.0),
                                                    child: Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      size: 20,
                                                    ),
                                                  ),
                                                  Text(
                                                    carListDetail[widget.index]
                                                        ['location'],
                                                    style: const TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      fontSize: 20,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Row(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.93,
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 0, 8, 0),
                                                child: ListView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Image.asset(
                                                          'images/speedometer.png',
                                                          width: 20,
                                                        ),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          child: const Text(
                                                            '180 kmph',
                                                            style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Image.asset(
                                                          'images/shift-stick.png',
                                                          width: 20,
                                                        ),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          child: Text(
                                                            carListDetail[widget
                                                                    .index][
                                                                'transmission'],
                                                            style:
                                                                const TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Image.asset(
                                                          'images/mileage.png',
                                                          width: 20,
                                                        ),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          child: Text(
                                                            carListDetail[widget
                                                                    .index]
                                                                ['mileage'],
                                                            style:
                                                                const TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Image.asset(
                                                          'images/fuel.png',
                                                          width: 20,
                                                        ),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          child: Text(
                                                            carListDetail[widget
                                                                .index]['fuel'],
                                                            style:
                                                                const TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
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
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                0.0, 0.0, 0.0, 15.0),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Text(
                                                carListDetail[widget.index]
                                                    ['description'],
                                                softWrap: true,
                                                textAlign: TextAlign.justify,
                                                maxLines: 3,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    margin: EdgeInsets.only(
                                        bottom: _w / 20,
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
                            FirebaseFirestore.instance
                                .collection('Favorite')
                                .doc(carListDetail[widget.index]['itemID'] +
                                    carListDetail[widget.index]['userID'])
                                .set({
                              'userID': currentUserID,
                              'type': carListDetail[widget.index]['type'],
                              'price': carListDetail[widget.index]['price'],
                              'image': carListDetail[widget.index]['image'],
                              'description': carListDetail[widget.index]
                                  ['description'],
                              'location': carListDetail[widget.index]
                                  ['location'],
                              'title': carListDetail[widget.index]['title'],
                              'year': carListDetail[widget.index]['year'],
                              'capacity': carListDetail[widget.index]
                                  ['capacity'],
                              'color': carListDetail[widget.index]['color'],
                              'condition': carListDetail[widget.index]
                                  ['condition'],
                              'exchangePossible': carListDetail[widget.index]
                                  ['exchangePossible'],
                              'fuel': carListDetail[widget.index]['fuel'],
                              'make': carListDetail[widget.index]['make'],
                              'mileage': carListDetail[widget.index]['mileage'],
                              'itemType': carListDetail[widget.index]
                                  ['itemType'],
                              'itemID': carListDetail[widget.index]['itemID'],
                              'transmission': carListDetail[widget.index]
                                  ['transmission'],
                              'isFavorite': !_isLiked,
                            });
                          });
                        }),
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
                  )
                ],
              );
            }));
  }
}
