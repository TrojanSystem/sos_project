import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'car_detail.dart';
import 'car_search_area.dart';
import 'list_of_available_car.dart';

class CarHomeScreen extends StatefulWidget {
  const CarHomeScreen({Key key}) : super(key: key);

  @override
  State<CarHomeScreen> createState() => _CarHomeScreenState();
}

class _CarHomeScreenState extends State<CarHomeScreen> {
  bool _likedItem = false;
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
    return Scaffold(
      backgroundColor: const Color.fromRGBO(40, 53, 147, 1),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.858,
          child: Column(
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromRGBO(92, 107, 192, 1),
                      const Color.fromRGBO(92, 107, 192, 1).withOpacity(0.9)
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
                        const Color.fromRGBO(40, 53, 147, 1).withOpacity(0.9)
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  ' Brands',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: ListView.builder(
                                itemBuilder: (context, index) => Container(
                                  width: 80,
                                  margin: const EdgeInsets.all(10),
                                  child: Material(
                                    //shadowColor: Colors.grey[200],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    elevation: 50,
                                    child: Image.asset(
                                      'images/${carBrand[index]}',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                itemCount: carBrand.length,
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                            Expanded(
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
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'New Cars',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    MaterialButton(
                                      color: Colors.blue[800],
                                      elevation: 20,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side:
                                            BorderSide(color: Colors.blue[800]),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (ctx) =>
                                                const ListOfAvailableCars(),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'More',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: AnimationLimiter(
                          child: ListView.builder(
                            itemCount: 10,
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            padding: EdgeInsets.all(_w / 60),
                            itemBuilder: (context, index) =>
                                AnimationConfiguration.staggeredGrid(
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
                                    child: carDetailList(context, _w),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container carDetailList(BuildContext context, double _w) {
    return Container(
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
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
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
                        side: BorderSide(color: Colors.blue[800]),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => CarDetail(),
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
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
