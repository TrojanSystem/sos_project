import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';

import '../collection_methods.dart';

class HouseDetail extends StatefulWidget {
  HouseDetail(
      {@required this.price,
      @required this.type,
      @required this.image,
      @required this.location,
      @required this.isFavorite,
      @required this.facility,
      @required this.area,
      @required this.title,
      @required this.description});
  String title;
  String description;
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
                              widget.image,
                              fit: BoxFit.contain,
                            ),
                            margin:
                                EdgeInsets.only(left: _w / 60, right: _w / 60),
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
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            18.0, 10, 0, 15),
                                        child: Text(
                                          widget.title,
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
                                            widget.location,
                                            style: const TextStyle(
                                              decoration: TextDecoration.none,
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
                                  child: AnimationConfiguration.staggeredGrid(
                                    position: 0,
                                    duration: const Duration(milliseconds: 500),
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
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.93,
                                                      padding: const EdgeInsets
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
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left: 8,
                                                                        right:
                                                                            8),
                                                                child: Text(
                                                                  '${widget.facility['beds']} beds',
                                                                  style:
                                                                      const TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    fontSize:
                                                                        18,
                                                                    color: Colors
                                                                        .grey,
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
                                                                'images/bath.png',
                                                                width: 20,
                                                              ),
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left: 8,
                                                                        right:
                                                                            8),
                                                                child: Text(
                                                                  '${widget.facility['bath']} bath',
                                                                  style:
                                                                      const TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    fontSize:
                                                                        18,
                                                                    color: Colors
                                                                        .grey,
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
                                                                'images/parking-sign.png',
                                                                width: 20,
                                                              ),
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left: 8,
                                                                        right:
                                                                            8),
                                                                child: Text(
                                                                  '${widget.facility['parking']} parking',
                                                                  style:
                                                                      const TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    fontSize:
                                                                        18,
                                                                    color: Colors
                                                                        .grey,
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
                                                                'images/area.png',
                                                                width: 20,
                                                              ),
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left: 8,
                                                                        right:
                                                                            8),
                                                                child: Text(
                                                                  '${widget.facility['area']}',
                                                                  style:
                                                                      const TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    fontSize:
                                                                        18,
                                                                    color: Colors
                                                                        .grey,
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
                                      widget.description,
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
                  widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.pink[800],
                ),
              ),
              onPressed: () {
                setState(() {
                  widget.isFavorite = !widget.isFavorite;
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
