import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'house_detail.dart';

class ListOfAvailableHouse extends StatefulWidget {
  ListOfAvailableHouse({this.type, this.houseType});
  String type;
  List houseType;

  @override
  State<ListOfAvailableHouse> createState() => _ListOfAvailableHouseState();
}

class _ListOfAvailableHouseState extends State<ListOfAvailableHouse> {
  bool _likedItem = false;

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    int columnCount = 3;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(40, 53, 147, 1),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(40, 53, 147, 1),
        ),
        child: AnimationLimiter(
          child: widget.houseType.isNotEmpty
              ? ListView.builder(
                  itemCount: widget.houseType.length,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  padding: EdgeInsets.all(_w / 60),
                  itemBuilder: (context, index) {
                    final typeFilter = widget.houseType
                        .where((element) => element.type == widget.type)
                        .toList();
                    return AnimationConfiguration.staggeredGrid(
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
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: _w * 0.35,
                                color: Colors.white,
                                margin: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Image.asset(
                                        typeFilter[index].image,
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
                                            typeFilter[index].title,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 20),
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                  Icons.location_on_outlined),
                                              Text(
                                                typeFilter[index].location,
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
                                                        image: typeFilter[index]
                                                            .image,
                                                        description:
                                                            typeFilter[index]
                                                                .description,
                                                        title: typeFilter[index]
                                                            .title,
                                                        area: typeFilter[index]
                                                            .area,
                                                        facility:
                                                            typeFilter[index]
                                                                .facility,
                                                        type: typeFilter[index]
                                                            .type,
                                                        price: typeFilter[index]
                                                            .price,
                                                        location:
                                                            typeFilter[index]
                                                                .location,
                                                        isFavorite:
                                                            typeFilter[index]
                                                                .isFavorite,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: const Text(
                                                  'Detail',
                                                  style: TextStyle(
                                                      color: Colors.white),
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
                    );
                  })
              : Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/no-data.png',
                      width: 150,
                    ),
                    const Text(
                      'No Data Entry',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                      ),
                    )
                  ],
                )),
        ),
      ),
    );
  }
}
