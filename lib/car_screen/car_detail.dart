import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';

import '../collection_methods.dart';

class CarDetail extends StatefulWidget {
  CarDetail({Key key}) : super(key: key);

  @override
  State<CarDetail> createState() => _CarDetailState();
}

class _CarDetailState extends State<CarDetail> {
  bool _likedItem = false;

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
      body: Stack(
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
                            child: Image.asset(
                              'images/1.png',
                              fit: BoxFit.contain,
                            ),
                            margin: EdgeInsets.only(
                                bottom: _w / 30, left: _w / 60, right: _w / 60),
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
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
                                      const Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            18.0, 15, 0, 15),
                                        child: Text(
                                          'Isuzu 2001 Model',
                                          style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontSize: 25,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: const [
                                          Icon(
                                            Icons.location_on_outlined,
                                            size: 34,
                                          ),
                                          Text(
                                            'Nazret, Ethiopia',
                                            style: TextStyle(
                                              decoration: TextDecoration.none,
                                              fontSize: 20,
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
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 350,
                                        padding: const EdgeInsets.fromLTRB(
                                            17, 0, 8, 8),
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                  'images/speedometer.png',
                                                  width: 40,
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: const Text(
                                                    '180 kmph',
                                                    style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      fontSize: 20,
                                                      color: Colors.grey,
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
                                                  'images/shift-stick.png',
                                                  width: 40,
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: const Text(
                                                    'Auto',
                                                    style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      fontSize: 20,
                                                      color: Colors.grey,
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
                                                  'images/mileage.png',
                                                  width: 40,
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: const Text(
                                                    '100000',
                                                    style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      fontSize: 20,
                                                      color: Colors.grey,
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
                                                  'images/fuel.png',
                                                  width: 40,
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: const Text(
                                                    'Benzene',
                                                    style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      fontSize: 20,
                                                      color: Colors.grey,
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
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        0.0, 0.0, 0.0, 15.0),
                                    child: const Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Text(
                                        ' we have to create an 1800 under air 2bedroom- 1 or 2 rooms extra to be used as gym and we have to create an 1800 under air 2bedroom- 1 or 2 rooms extra to be used as gym and we have to create an 1800 under air 2bedroom- 1 or 2 rooms extra to be used as gym and',
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
                                bottom: _w / 60, left: _w / 60, right: _w / 60),
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
                  _likedItem ? Icons.favorite : Icons.favorite_border,
                  color: Colors.pink[800],
                ),
              ),
              onPressed: () {
                setState(() {
                  _likedItem = !_likedItem;
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
          )
        ],
      ),
    );
  }
}
