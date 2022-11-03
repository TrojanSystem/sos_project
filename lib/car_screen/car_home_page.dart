import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import '../crediential/data_provider.dart';
import 'car_detail.dart';
import 'car_home_page_ui.dart';
import 'car_search_area.dart';

final _auth = FirebaseAuth.instance;
var loggedInUser;

class CarHomeScreen extends StatefulWidget {
  const CarHomeScreen({Key key}) : super(key: key);

  @override
  State<CarHomeScreen> createState() => _CarHomeScreenState();
}

class _CarHomeScreenState extends State<CarHomeScreen> {
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

  bool _isFavoriteItem = false;
  String currentUserID = '';
  String currentUser = '';
  String currentUserName = '';
  String currentProfilePic = '';
  List<String> carBrand = [
    'tesla.png',
    'honda.png',
    'ford.png',
    'Mazda.png',
    'toyota.png',
    'Suzuki.png'
  ];
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    int columnCount = 3;
    double _rating = 0.0;
    var newRate = const RangeValues(0.2, 20.0);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(40, 53, 147, 1),
        body: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('CarModel').snapshots(),
            builder: (context, carModel) {
              if (!carModel.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final registeredUsers =
                  Provider.of<DataProvider>(context).registeredMembers;
              final userFavoriteList = Provider.of<DataProvider>(context)
                  .registeredUserFavoriteItems;
              for (var message in registeredUsers) {
                if (message['userID'] == loggedInUser) {
                  currentUserID = message['userID'];
                  currentUser = message['userEmail'];
                  currentUserName = message['userFullName'];
                  currentProfilePic = message['profilePic'];
                }
              }
              final carData = carModel.data.docs;
              return SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.858,
                  child: Column(
                    children: [
                      Container(
                        height: 10,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color.fromRGBO(92, 107, 192, 1),
                              const Color.fromRGBO(92, 107, 192, 1)
                                  .withOpacity(0.9)
                            ],
                          ),
                        ),
                      ),
                      CarSearchArea(newRate: newRate),
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color.fromRGBO(40, 53, 147, 1),
                                const Color.fromRGBO(40, 53, 147, 1)
                                    .withOpacity(0.9)
                              ],
                            ),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: CarBrandsList(
                                    carBrand: carBrand, carList: carData),
                              ),
                              Expanded(
                                flex: 2,
                                child: AnimationLimiter(
                                  child: ListView.builder(
                                      itemCount: carData.length,
                                      physics: const BouncingScrollPhysics(
                                          parent:
                                              AlwaysScrollableScrollPhysics()),
                                      padding: EdgeInsets.all(_w / 60),
                                      itemBuilder: (context, index) {
                                        for (var message in userFavoriteList) {
                                          if (currentUserID == loggedInUser &&
                                              carData[index]['itemID'] ==
                                                  message['itemID']) {
                                            _isFavoriteItem =
                                                message['isFavorite'];
                                          }
                                        }

                                        return AnimationConfiguration
                                            .staggeredGrid(
                                          position: index,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          columnCount: columnCount,
                                          child: ScaleAnimation(
                                            duration: const Duration(
                                                milliseconds: 900),
                                            curve:
                                                Curves.fastLinearToSlowEaseIn,
                                            child: FadeInAnimation(
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    bottom: _w / 60,
                                                    left: _w / 60,
                                                    right: _w / 60),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(20)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.1),
                                                      blurRadius: 40,
                                                      spreadRadius: 10,
                                                    ),
                                                  ],
                                                ),
                                                child: Container(
                                                  height: _w * 0.35,
                                                  color: Colors.white,
                                                  margin:
                                                      const EdgeInsets.all(8),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        flex: 1,
                                                        child: Image.asset(
                                                          carData[index]
                                                              ['image'],
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              carData[index]
                                                                  ['title'],
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w900,
                                                                  fontSize: 20),
                                                            ),
                                                            Row(
                                                              children: [
                                                                const Icon(Icons
                                                                    .location_on_outlined),
                                                                Text(
                                                                  carData[index]
                                                                      [
                                                                      'location'],
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          15),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: const [
                                                                Icon(
                                                                  Icons
                                                                      .star_rate_rounded,
                                                                  color: Colors
                                                                      .amber,
                                                                ),
                                                                Text(
                                                                  '4.5 ',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18),
                                                                ),
                                                                Text(
                                                                  ' (485 Reviews)',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18),
                                                                )
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                MaterialButton(
                                                                  color: Colors
                                                                          .blue[
                                                                      800],
                                                                  elevation: 20,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    side: BorderSide(
                                                                        color: Colors
                                                                            .blue[800]),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .push(
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (ctx) =>
                                                                                CarDetail(
                                                                          index:
                                                                              index,
                                                                          userID:
                                                                              currentUserID,
                                                                          itemID:
                                                                              carData[index]['itemID'],
                                                                          itemType:
                                                                              carData[index]['itemType'],
                                                                          type: carData[index]
                                                                              [
                                                                              'type'],
                                                                          price:
                                                                              carData[index]['price'],
                                                                          image:
                                                                              carData[index]['image'],
                                                                          description:
                                                                              carData[index]['description'],
                                                                          location:
                                                                              carData[index]['location'],
                                                                          title:
                                                                              carData[index]['title'],
                                                                          year: carData[index]
                                                                              [
                                                                              'year'],
                                                                          capacity:
                                                                              carData[index]['capacity'],
                                                                          color:
                                                                              carData[index]['color'],
                                                                          condition:
                                                                              carData[index]['condition'],
                                                                          exchangePossible:
                                                                              carData[index]['exchangePossible'],
                                                                          fuel: carData[index]
                                                                              [
                                                                              'fuel'],
                                                                          make: carData[index]
                                                                              [
                                                                              'make'],
                                                                          mileage:
                                                                              carData[index]['mileage'],
                                                                          transmission:
                                                                              carData[index]['transmission'],
                                                                          isFavorite:
                                                                              !_isFavoriteItem,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                    'Detail',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                                MaterialButton(
                                                                  shape:
                                                                      const CircleBorder(),
                                                                  elevation: 15,
                                                                  color: Colors
                                                                      .white,
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .all(
                                                                        15.0),
                                                                    child: Icon(
                                                                      _isFavoriteItem
                                                                          ? Icons
                                                                              .favorite
                                                                          : Icons
                                                                              .favorite_border,
                                                                      color: Colors
                                                                              .pink[
                                                                          800],
                                                                    ),
                                                                  ),
                                                                  onPressed:
                                                                      () async {
                                                                    setState(
                                                                        () {
                                                                      FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              'Favorite')
                                                                          .doc(carData[index]
                                                                              [
                                                                              'itemID'])
                                                                          .set({
                                                                        'userID':
                                                                            currentUserID,
                                                                        'itemID':
                                                                            carData[index]['itemID'],
                                                                        'itemType':
                                                                            carData[index]['itemType'],
                                                                        'type': carData[index]
                                                                            [
                                                                            'type'],
                                                                        'price':
                                                                            carData[index]['price'],
                                                                        'image':
                                                                            carData[index]['image'],
                                                                        'description':
                                                                            carData[index]['description'],
                                                                        'location':
                                                                            carData[index]['location'],
                                                                        'title':
                                                                            carData[index]['title'],
                                                                        'year': carData[index]
                                                                            [
                                                                            'year'],
                                                                        'capacity':
                                                                            carData[index]['capacity'],
                                                                        'color':
                                                                            carData[index]['color'],
                                                                        'condition':
                                                                            carData[index]['condition'],
                                                                        'exchangePossible':
                                                                            carData[index]['exchangePossible'],
                                                                        'fuel': carData[index]
                                                                            [
                                                                            'fuel'],
                                                                        'make': carData[index]
                                                                            [
                                                                            'make'],
                                                                        'mileage':
                                                                            carData[index]['mileage'],
                                                                        'transmission':
                                                                            carData[index]['transmission'],
                                                                        'isFavorite':
                                                                            !_isFavoriteItem,
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
                                      }),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
