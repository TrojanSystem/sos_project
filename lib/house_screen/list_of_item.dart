import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

import 'house_detail.dart';

class ListOfItems extends StatelessWidget {
  NumberFormat numberGrouper = NumberFormat.decimalPattern('en_us');
  ListOfItems(
      {Key key,
      @required double w,
      @required this.columnCountForMain,
      @required this.columnCount,
      @required this.listOfHouse})
      : _w = w,
        super(key: key);

  final double _w;
  final List listOfHouse;
  final int columnCountForMain;
  final int columnCount;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
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
          child: GridView.count(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            padding: EdgeInsets.all(_w / 60),
            crossAxisCount: columnCountForMain,
            children: List.generate(
              listOfHouse.length,
              (int index) {
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: const Duration(milliseconds: 500),
                  columnCount: columnCount,
                  child: ScaleAnimation(
                    duration: const Duration(milliseconds: 900),
                    curve: Curves.fastLinearToSlowEaseIn,
                    child: FadeInAnimation(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: HouseDetail(
                                houseIndex: index,
                                houseID: listOfHouse[index].id,
                                image: listOfHouse[index]['image'],
                                description: listOfHouse[index]['description'],
                                itemType: listOfHouse[index]['itemType'],
                                itemID: listOfHouse[index]['itemID'],
                                title: listOfHouse[index]['title'],
                                isFavorite: listOfHouse[index]['isFavorite'],
                                location: listOfHouse[index]['location'],
                                price: listOfHouse[index]['price'],
                                type: listOfHouse[index]['type'],
                                area: listOfHouse[index]['area'],
                                facility: listOfHouse[index]['facility'],
                              ),
                            ),
                          );
                        },
                        child: Container(
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
                          child: ClipRRect(
                            child: FancyShimmerImage(
                              boxFit: BoxFit.contain,
                              imageUrl:
                                  'https://images.unsplash.com/photo-1465572089651-8fde36c892dd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
                              errorWidget: Image.network(
                                  'https://i0.wp.com/www.dobitaobyte.com.br/wp-content/uploads/2016/02/no_image.png?ssl=1'),
                              shimmerBaseColor: Colors.greenAccent,
                              shimmerHighlightColor: Colors.grey,
                              shimmerBackColor: Colors.greenAccent,
                            ),
                            clipBehavior: Clip.antiAlias,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
