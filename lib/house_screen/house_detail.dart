import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../data_storage.dart';

class HouseDetail extends StatefulWidget {
  HouseDetail({Key key}) : super(key: key);

  @override
  State<HouseDetail> createState() => _HouseDetailState();
}

class _HouseDetailState extends State<HouseDetail> {
  var items = [
    'CBE',
    'Awach',
    'Abyssinia',
    'Dashen',
    'Awash',
  ];
  bool _likedItem = false;
  bool _isSelected = false;
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;

    int columnCount = 1;

    return Scaffold(
      body: Consumer<DataStorage>(
        builder: (context, provider, child) {
          String dropdownvalue = Provider.of<DataStorage>(context).dropValue;
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
                                clipBehavior: Clip.antiAlias,
                                child: Image.asset(
                                  'images/images.jpg',
                                  fit: BoxFit.fill,
                                ),
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
                                              '140 m\u00B2 House',
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
                                                'Dukem, Ethiopia',
                                                style: TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
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
                                                      'images/double-bed.png',
                                                      width: 25,
                                                    ),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      child: const Text(
                                                        '3 beds',
                                                        style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
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
                                                      'images/bath.png',
                                                      width: 25,
                                                    ),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      child: const Text(
                                                        '2 bath',
                                                        style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
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
                                                      'images/parking-sign.png',
                                                      width: 25,
                                                    ),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      child: const Text(
                                                        '1 parking',
                                                        style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
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
                                                      'images/area.png',
                                                      width: 25,
                                                    ),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      child: const Text(
                                                        '140 m\u00B2',
                                                        style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
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
                                    bottom: _w / 60,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                actions: [
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      margin: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            const Color.fromRGBO(
                                                40, 53, 147, 1),
                                            const Color.fromRGBO(40, 53, 147, 1)
                                                .withOpacity(0.9)
                                          ],
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            blurRadius: 4,
                                            offset: const Offset(4,
                                                8), // changes position of shadow
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      padding: const EdgeInsets.fromLTRB(
                                          16.0, 8, 8, 8),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'images/cash-bag.png',
                                            width: 40,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            'CASH',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w900,
                                                fontSize: 25),
                                          )
                                        ],
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      whichBank(context, _w);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            const Color.fromRGBO(
                                                40, 53, 147, 1),
                                            const Color.fromRGBO(40, 53, 147, 1)
                                                .withOpacity(0.9)
                                          ],
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            blurRadius: 4,
                                            offset: const Offset(4,
                                                8), // changes position of shadow
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      padding: const EdgeInsets.fromLTRB(
                                          16.0, 8, 8, 8),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'images/loan.png',
                                            width: 40,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            'LOAN',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w900,
                                                fontSize: 25),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                                title: const Text('Buying Process'),
                                alignment: Alignment.center,
                              );
                            },
                          );
                        });
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
              )
            ],
          );
        },
      ),
    );
  }

  void whichBank(BuildContext context, double _w) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Which Bank'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: items
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 8, 8, 8),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _isSelected = !_isSelected;
                              });
                            },
                            icon: const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(
                            width: _w * 0.01,
                          ),
                          Text(e)
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ok'))
            ],
          );
        });
  }
}
