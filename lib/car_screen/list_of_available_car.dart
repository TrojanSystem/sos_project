import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'car_detail.dart';

class ListOfAvailableCars extends StatefulWidget {
  const ListOfAvailableCars({Key key}) : super(key: key);

  @override
  State<ListOfAvailableCars> createState() => _ListOfAvailableCarsState();
}

class _ListOfAvailableCarsState extends State<ListOfAvailableCars> {
  bool _likedItem = false;

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    int columnCount = 3;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
      ),
      body: AnimationLimiter(
        child: ListView.builder(
          itemCount: 10,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          padding: EdgeInsets.all(_w / 60),
          itemBuilder: (context, index) => AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 500),
            columnCount: columnCount,
            child: ScaleAnimation(
              duration: const Duration(milliseconds: 900),
              curve: Curves.fastLinearToSlowEaseIn,
              child: FadeInAnimation(
                child: Container(
                  margin: EdgeInsets.only(
                      bottom: _w / 30, left: _w / 60, right: _w / 60),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 40,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => CarDetail(),
                        ),
                      );
                    },
                    child: Container(
                      height: _w * 0.35,
                      color: Colors.white,
                      margin: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Image.asset(
                              'images/ford.jpg',
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Ford Latest',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 20),
                                ),
                                Row(
                                  children: const [
                                    Icon(Icons.location_on_outlined),
                                    Text(
                                      'Dukem, Ethiopia',
                                      style: TextStyle(fontSize: 15),
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
                                        borderRadius: BorderRadius.circular(10),
                                        side:
                                            BorderSide(color: Colors.blue[800]),
                                      ),
                                      onPressed: () {},
                                      child: const Text('Bid'),
                                    ),
                                    MaterialButton(
                                      shape: const CircleBorder(),
                                      elevation: 15,
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Icon(
                                          _likedItem
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: Colors.pink[800],
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _likedItem = !_likedItem;
                                        });
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
        ),
      ),
    );
  }
}
