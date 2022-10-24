import 'package:ada_bread/house_screen/house_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import 'list_of_available_house.dart';

class ChoiceOfItems extends StatelessWidget {
  const ChoiceOfItems({
    Key key,
    @required this.columnCount,
    @required double w,
  })  : _w = w,
        super(key: key);

  final int columnCount;
  final double _w;

  @override
  Widget build(BuildContext context) {
    return Consumer<HouseData>(
      builder: (context, type, child) {
        final typeFilterHouse =
            type.houseList.where((element) => element.type == 'house').toList();
        final typeFilterApartment = type.houseList
            .where((element) => element.type == 'apartment')
            .toList();
        final typeFilterCondo =
            type.houseList.where((element) => element.type == 'condo').toList();
        final typeFilterHotels = type.houseList
            .where((element) => element.type == 'hotels')
            .toList();

        return Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: AnimatedContainer(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromRGBO(92, 107, 192, 1),
                    const Color.fromRGBO(92, 107, 192, 1).withOpacity(0.9)
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
              duration: const Duration(seconds: 1),
              curve: Curves.fastLinearToSlowEaseIn,
              height: 200,
              width: double.infinity,
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: AnimationLimiter(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                ListOfAvailableHouse(
                                                  type: 'condo',
                                                  houseType: typeFilterCondo,
                                                )));
                                  },
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
                                          margin: EdgeInsets.only(
                                            bottom: _w / 60,
                                            top: _w / 30,
                                            left: _w / 30,
                                            right: _w / 60,
                                          ),
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
                                            padding: const EdgeInsets.fromLTRB(
                                                17, 8, 8, 8),
                                            width: 150,
                                            height: 70,
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  'images/office-building.png',
                                                  width: 50,
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Column(
                                                    children: [
                                                      const Text(
                                                        'Condo',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            fontSize: 15),
                                                      ),
                                                      Text(
                                                          '${typeFilterCondo.length} Items')
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
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                ListOfAvailableHouse(
                                                  type: 'apartment',
                                                  houseType:
                                                      typeFilterApartment,
                                                )));
                                  },
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
                                          margin: EdgeInsets.only(
                                            bottom: _w / 60,
                                            top: _w / 30,
                                            left: _w / 30,
                                            right: _w / 60,
                                          ),
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
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 8, 8, 8),
                                            height: 70,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: Image.asset(
                                                    'images/apartment.png',
                                                    width: 50,
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 7,
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: Column(
                                                      children: [
                                                        const Text(
                                                          'Apartments',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              fontSize: 15),
                                                        ),
                                                        Text(
                                                            '${typeFilterApartment.length} Items')
                                                      ],
                                                    ),
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
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                ListOfAvailableHouse(
                                                  type: 'house',
                                                  houseType: typeFilterHouse,
                                                )));
                                  },
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
                                          margin: EdgeInsets.only(
                                            bottom: _w / 60,
                                            top: _w / 30,
                                            left: _w / 30,
                                            right: _w / 60,
                                          ),
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
                                            padding: const EdgeInsets.fromLTRB(
                                                17, 8, 8, 8),
                                            width: 150,
                                            height: 70,
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  'images/house.png',
                                                  width: 50,
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Column(
                                                    children: [
                                                      const Text(
                                                        'House',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            fontSize: 15),
                                                      ),
                                                      Text(
                                                          '${typeFilterHouse.length} Items')
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
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                ListOfAvailableHouse(
                                                  type: 'hotels',
                                                  houseType: typeFilterHotels,
                                                )));
                                  },
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
                                          margin: EdgeInsets.only(
                                            bottom: _w / 60,
                                            top: _w / 30,
                                            left: _w / 30,
                                            right: _w / 60,
                                          ),
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
                                            padding: const EdgeInsets.fromLTRB(
                                                17, 8, 8, 8),
                                            width: 150,
                                            height: 70,
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  'images/review.png',
                                                  width: 50,
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Column(
                                                    children: [
                                                      const Text(
                                                        'Hotels',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            fontSize: 15),
                                                      ),
                                                      Text(
                                                          '${typeFilterHotels.length} Items')
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
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
