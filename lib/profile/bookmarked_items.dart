import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';

import '../house_screen/house_detail.dart';

class BookmarkedItems extends StatefulWidget {
  BookmarkedItems({Key key}) : super(key: key);

  @override
  State<BookmarkedItems> createState() => _BookmarkedItemsState();
}

class _BookmarkedItemsState extends State<BookmarkedItems> {
  NumberFormat numberFormat = NumberFormat.decimalPattern('en_us');

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
          stream:
              FirebaseFirestore.instance.collection('HomeDetail').snapshots(),
          builder: (context, bookmark) {
            if (!bookmark.hasData) {
              return const CircularProgressIndicator();
            }
            final booked = bookmark.data.docs;
            final bookmarked = booked
                .where((element) => element['isFavorite'] == true)
                .toList();
            return bookmarked.isEmpty
                ? Center(
                    child: Column(
                      children: [
                        Image.asset('images/bookmark.png'),
                        Text('browse more')
                      ],
                    ),
                  )
                : AnimationLimiter(
                    child: ListView.builder(
                      itemCount: bookmarked.length,
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      padding: EdgeInsets.all(_w / 60),
                      itemBuilder: (context, index) =>
                          AnimationConfiguration.staggeredGrid(
                        position: index,
                        duration: const Duration(milliseconds: 500),
                        columnCount: 1,
                        child: ScaleAnimation(
                          duration: const Duration(milliseconds: 900),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            child: Container(
                              margin: EdgeInsets.only(
                                  bottom: _w / 60,
                                  left: _w / 60,
                                  right: _w / 60),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
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
                                                fontWeight: FontWeight.w900,
                                                fontSize: 20),
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                  Icons.location_on_outlined),
                                              Text(
                                                bookmarked[index]['location'],
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
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              Text(
                                                ' (485 Reviews)',
                                                style: TextStyle(fontSize: 18),
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
                                                      BorderRadius.circular(10),
                                                  side: BorderSide(
                                                      color: Colors.blue[800]),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (ctx) =>
                                                          HouseDetail(
                                                        houseID:
                                                            bookmarked[index]
                                                                .id,
                                                        houseIndex: index,
                                                        image: bookmarked[index]
                                                            ['image'],
                                                        description:
                                                            bookmarked[index]
                                                                ['description'],
                                                        title: bookmarked[index]
                                                            ['title'],
                                                        area: bookmarked[index]
                                                            ['area'],
                                                        facility:
                                                            bookmarked[index]
                                                                ['facility'],
                                                        type: bookmarked[index]
                                                            ['type'],
                                                        price: numberFormat
                                                            .format(bookmarked[
                                                                index]['price'])
                                                            .toString(),
                                                        location:
                                                            bookmarked[index]
                                                                ['location'],
                                                        isFavorite:
                                                            bookmarked[index]
                                                                ['isFavorite'],
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: const Text(
                                                  'Detail',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              MaterialButton(
                                                shape: const CircleBorder(),
                                                elevation: 15,
                                                color: Colors.white,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Icon(
                                                    bookmarked[index]
                                                            ['isFavorite']
                                                        ? Icons.favorite
                                                        : Icons.favorite_border,
                                                    color: Colors.pink[800],
                                                  ),
                                                ),
                                                onPressed: () async {
                                                  setState(
                                                    () {
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'HomeDetail')
                                                          .doc(bookmarked[index]
                                                              .id)
                                                          .update(
                                                        {
                                                          'image':
                                                              bookmarked[index]
                                                                  ['image'],
                                                          'description':
                                                              bookmarked[index][
                                                                  'description'],
                                                          'title':
                                                              bookmarked[index]
                                                                  ['title'],
                                                          'area':
                                                              bookmarked[index]
                                                                  ['area'],
                                                          'facility':
                                                              bookmarked[index]
                                                                  ['facility'],
                                                          'type':
                                                              bookmarked[index]
                                                                  ['type'],
                                                          'price':
                                                              bookmarked[index]
                                                                  ['price'],
                                                          'location':
                                                              bookmarked[index]
                                                                  ['location'],
                                                          'isFavorite':
                                                              !bookmarked[index]
                                                                  [
                                                                  'isFavorite'],
                                                        },
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                            ],
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                      ),
                    ),
                  );
          }),
    );
  }
}
