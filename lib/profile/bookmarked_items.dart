import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../car_screen/car_detail.dart';
import '../crediential/data_provider.dart';
import '../house_screen/house_detail.dart';

final _auth = FirebaseAuth.instance;
var loggedInUser;

class BookmarkedItems extends StatefulWidget {
  BookmarkedItems({Key key}) : super(key: key);

  @override
  State<BookmarkedItems> createState() => _BookmarkedItemsState();
}

class _BookmarkedItemsState extends State<BookmarkedItems> {
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
  String dateTime = DateTime.now().toString();
  String currentUserID;
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Book',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(text: ' '),
              TextSpan(
                  text: 'marked',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Favorite').snapshots(),
          builder: (context, bookmark) {
            if (!bookmark.hasData) {
              return const CircularProgressIndicator();
            }
            final userFavItems =
                Provider.of<DataProvider>(context).registeredMembers;
            final userFavoriteList =
                Provider.of<DataProvider>(context).registeredUserFavoriteItems;
            for (var message in userFavItems) {
              if (message['userID'] == loggedInUser) {
                currentUserID = message['userID'];
              }
            }
            final booked = bookmark.data.docs;
            final checker = booked
                .where((element) => element['userID'] == loggedInUser)
                .toList();
            final bookmarked = checker
                .where((element) => element['isFavorite'] == true)
                .toList();
            return bookmarked.isEmpty
                ? Center(
                    child: Column(
                      children: [
                        Image.asset('images/bookmark.png'),
                        const Text('browse more')
                      ],
                    ),
                  )
                : AnimationLimiter(
                    child: ListView.builder(
                        itemCount: bookmarked.length,
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        padding: EdgeInsets.all(_w / 120),
                        itemBuilder: (context, index) {
                          for (var message in userFavoriteList) {
                            if (message['userID'] == loggedInUser &&
                                bookmarked[index]['itemID'] ==
                                    message['itemID']) {
                              _isLiked = message['isFavorite'];
                            }
                          }
                          return currentUserID == loggedInUser
                              ? bookmarked[index]['itemType'] == 'house'
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: _w * 0.35,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              blurRadius: 40,
                                              spreadRadius: 10,
                                            ),
                                          ],
                                        ),
                                        margin: const EdgeInsets.all(8),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: ClipRRect(
                                                child: Image.asset(
                                                  bookmarked[index]['image'],
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
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    bookmarked[index]['title'],
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        fontSize: 20),
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Icon(Icons
                                                          .location_on_outlined),
                                                      Text(
                                                        bookmarked[index]
                                                            ['location'],
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
                                                        style: TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                      Text(
                                                        ' (485 Reviews)',
                                                        style: TextStyle(
                                                            fontSize: 18),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      MaterialButton(
                                                        color: Colors.blue[800],
                                                        elevation: 20,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          side: BorderSide(
                                                              color: Colors
                                                                  .blue[800]),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .push(
                                                            MaterialPageRoute(
                                                              builder: (ctx) =>
                                                                  HouseDetail(
                                                                houseID:
                                                                    currentUserID,
                                                                houseIndex:
                                                                    index,
                                                                itemID: bookmarked[
                                                                        index]
                                                                    ['itemID'],
                                                                itemType: bookmarked[
                                                                        index][
                                                                    'itemType'],
                                                                image: bookmarked[
                                                                        index]
                                                                    ['image'],
                                                                description:
                                                                    bookmarked[
                                                                            index]
                                                                        [
                                                                        'description'],
                                                                title: bookmarked[
                                                                        index]
                                                                    ['title'],
                                                                area: bookmarked[
                                                                        index]
                                                                    ['area'],
                                                                facility: bookmarked[
                                                                        index][
                                                                    'facility'],
                                                                type: bookmarked[
                                                                        index]
                                                                    ['type'],
                                                                price: numberFormat
                                                                    .format(bookmarked[
                                                                            index]
                                                                        [
                                                                        'price'])
                                                                    .toString(),
                                                                location: bookmarked[
                                                                        index][
                                                                    'location'],
                                                                isFavorite:
                                                                    bookmarked[
                                                                            index]
                                                                        [
                                                                        'isFavorite'],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child: const Text(
                                                          'Detail',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                      MaterialButton(
                                                        shape:
                                                            const CircleBorder(),
                                                        elevation: 15,
                                                        color: Colors.white,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child: Icon(
                                                            _isLiked
                                                                ? Icons.favorite
                                                                : Icons
                                                                    .favorite_border,
                                                            color: Colors
                                                                .pink[800],
                                                          ),
                                                        ),
                                                        onPressed: () async {
                                                          setState(() {
                                                            final houseID = Provider.of<
                                                                        DataProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .houseV4Crypto;
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'Favorite')
                                                                .doc(bookmarked[
                                                                        index]
                                                                    ['itemID'])
                                                                .set({
                                                              'userID':
                                                                  currentUserID,
                                                              'itemID':
                                                                  bookmarked[
                                                                          index]
                                                                      [
                                                                      'itemID'],
                                                              'itemType':
                                                                  bookmarked[
                                                                          index]
                                                                      [
                                                                      'itemType'],
                                                              'image':
                                                                  bookmarked[
                                                                          index]
                                                                      ['image'],
                                                              'description':
                                                                  bookmarked[
                                                                          index]
                                                                      [
                                                                      'description'],
                                                              'title':
                                                                  bookmarked[
                                                                          index]
                                                                      ['title'],
                                                              'area':
                                                                  bookmarked[
                                                                          index]
                                                                      ['area'],
                                                              'facility':
                                                                  bookmarked[
                                                                          index]
                                                                      [
                                                                      'facility'],
                                                              'type':
                                                                  bookmarked[
                                                                          index]
                                                                      ['type'],
                                                              'price':
                                                                  bookmarked[
                                                                          index]
                                                                      ['price'],
                                                              'location':
                                                                  bookmarked[
                                                                          index]
                                                                      [
                                                                      'location'],
                                                              'isFavorite':
                                                                  !_isLiked,
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
                                    )
                                  : Container(
                                      height: _w * 0.36,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            blurRadius: 40,
                                            spreadRadius: 10,
                                          ),
                                        ],
                                      ),
                                      margin: const EdgeInsets.all(8),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Image.asset(
                                              bookmarked[index]['image'],
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
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  bookmarked[index]['title'],
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      fontSize: 20),
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(Icons
                                                        .location_on_outlined),
                                                    Text(
                                                      bookmarked[index]
                                                          ['location'],
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
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                    Text(
                                                      ' (485 Reviews)',
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    MaterialButton(
                                                      color: Colors.blue[800],
                                                      elevation: 20,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        side: BorderSide(
                                                            color: Colors
                                                                .blue[800]),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (ctx) =>
                                                                CarDetail(
                                                              index: index,
                                                              userID:
                                                                  currentUserID,
                                                              type: bookmarked[
                                                                      index]
                                                                  ['type'],
                                                              itemType:
                                                                  bookmarked[
                                                                          index]
                                                                      [
                                                                      'itemType'],
                                                              itemID:
                                                                  bookmarked[
                                                                          index]
                                                                      [
                                                                      'itemID'],
                                                              price: bookmarked[
                                                                      index]
                                                                  ['price'],
                                                              image: bookmarked[
                                                                      index]
                                                                  ['image'],
                                                              description:
                                                                  bookmarked[
                                                                          index]
                                                                      [
                                                                      'description'],
                                                              location:
                                                                  bookmarked[
                                                                          index]
                                                                      [
                                                                      'location'],
                                                              title: bookmarked[
                                                                      index]
                                                                  ['title'],
                                                              year: bookmarked[
                                                                      index]
                                                                  ['year'],
                                                              capacity:
                                                                  bookmarked[
                                                                          index]
                                                                      [
                                                                      'capacity'],
                                                              color: bookmarked[
                                                                      index]
                                                                  ['color'],
                                                              condition:
                                                                  bookmarked[
                                                                          index]
                                                                      [
                                                                      'condition'],
                                                              exchangePossible:
                                                                  bookmarked[
                                                                          index]
                                                                      [
                                                                      'exchangePossible'],
                                                              fuel: bookmarked[
                                                                      index]
                                                                  ['fuel'],
                                                              make: bookmarked[
                                                                      index]
                                                                  ['make'],
                                                              mileage:
                                                                  bookmarked[
                                                                          index]
                                                                      [
                                                                      'mileage'],
                                                              transmission:
                                                                  bookmarked[
                                                                          index]
                                                                      [
                                                                      'transmission'],
                                                              isFavorite:
                                                                  !_isLiked,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: const Text(
                                                        'Detail',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    MaterialButton(
                                                        shape:
                                                            const CircleBorder(),
                                                        elevation: 15,
                                                        color: Colors.white,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child: Icon(
                                                            _isLiked
                                                                ? Icons.favorite
                                                                : Icons
                                                                    .favorite_border,
                                                            color: Colors
                                                                .pink[800],
                                                          ),
                                                        ),
                                                        onPressed: () async {
                                                          setState(() {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'Favorite')
                                                                .doc(
                                                                  bookmarked[
                                                                          index]
                                                                      [
                                                                      'itemID'],
                                                                )
                                                                .set({
                                                              'userID':
                                                                  currentUserID,
                                                              'type':
                                                                  bookmarked[
                                                                          index]
                                                                      ['type'],
                                                              'itemType':
                                                                  bookmarked[
                                                                          index]
                                                                      [
                                                                      'itemType'],
                                                              'itemID':
                                                                  bookmarked[
                                                                          index]
                                                                      [
                                                                      'itemID'],
                                                              'price':
                                                                  bookmarked[
                                                                          index]
                                                                      ['price'],
                                                              'image':
                                                                  bookmarked[
                                                                          index]
                                                                      ['image'],
                                                              'description':
                                                                  bookmarked[
                                                                          index]
                                                                      [
                                                                      'description'],
                                                              'location':
                                                                  bookmarked[
                                                                          index]
                                                                      [
                                                                      'location'],
                                                              'title':
                                                                  bookmarked[
                                                                          index]
                                                                      ['title'],
                                                              'year':
                                                                  bookmarked[
                                                                          index]
                                                                      ['year'],
                                                              'capacity':
                                                                  bookmarked[
                                                                          index]
                                                                      [
                                                                      'capacity'],
                                                              'color':
                                                                  bookmarked[
                                                                          index]
                                                                      ['color'],
                                                              'condition':
                                                                  bookmarked[
                                                                          index]
                                                                      [
                                                                      'condition'],
                                                              'exchangePossible':
                                                                  bookmarked[
                                                                          index]
                                                                      [
                                                                      'exchangePossible'],
                                                              'fuel':
                                                                  bookmarked[
                                                                          index]
                                                                      ['fuel'],
                                                              'make':
                                                                  bookmarked[
                                                                          index]
                                                                      ['make'],
                                                              'mileage':
                                                                  bookmarked[
                                                                          index]
                                                                      [
                                                                      'mileage'],
                                                              'transmission':
                                                                  bookmarked[
                                                                          index]
                                                                      [
                                                                      'transmission'],
                                                              'isFavorite':
                                                                  !_isLiked,
                                                            });
                                                          });
                                                        }),
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
                                    )
                              : const Center(
                                  child: Text('data'),
                                );
                        }),
                  );
          }),
    );
  }
}
