import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CarHomeScreen extends StatefulWidget {
  const CarHomeScreen({Key key}) : super(key: key);

  @override
  State<CarHomeScreen> createState() => _CarHomeScreenState();
}

class _CarHomeScreenState extends State<CarHomeScreen> {
  bool _likedItem = false;
  List carBrand = [
    'tesla.png',
    'honda.png',
    'ford.png',
    'Mazda.png',
    'mercedes.jpg',
    'Suzuki.png'
  ];
  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    int columnCount = 3;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0, bottom: 20),
                  child: Text(
                    'Let\'s Find Car as ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 28.0),
                  child: Text(
                    'your pocket ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.filter_alt_sharp,
                          ),
                        ),
                        prefixIcon: const Icon(Icons.search_outlined),
                        hintText: 'Search a car...'),
                  ),
                  margin: const EdgeInsets.fromLTRB(30, 30, 30, 8),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(
                        child: Text(
                          ' Brands',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: ListView.builder(
                          itemBuilder: (context, index) => Container(
                            margin: const EdgeInsets.all(8),
                            child: Material(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              elevation: 50,
                              child: Image.asset(
                                '${carBrand[index]}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          itemCount: carBrand.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'New Cars',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              MaterialButton(
                                color: Colors.blue[800],
                                elevation: 20,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: Colors.blue[800]),
                                ),
                                onPressed: () {},
                                child: const Text('More'),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  side: BorderSide(
                                                      color: Colors.blue[800]),
                                                ),
                                                onPressed: () {},
                                                child: const Text('Bid'),
                                              ),
                                              MaterialButton(
                                                shape: const CircleBorder(),
                                                elevation: 15,
                                                color: Colors.white,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
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
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
