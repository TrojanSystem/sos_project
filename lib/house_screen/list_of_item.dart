import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'house_detail.dart';
import 'house_model.dart';

class ListOfItems extends StatelessWidget {
  const ListOfItems({
    Key key,
    @required double w,
    @required this.columnCountForMain,
    @required this.columnCount,
  })  : _w = w,
        super(key: key);

  final double _w;
  final int columnCountForMain;
  final int columnCount;

  @override
  Widget build(BuildContext context) {
    return Consumer<HouseData>(
      builder: (context, houseData, child) => Expanded(
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
                houseData.houseList.length,
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
                                      image: houseData.houseList[index].image,
                                      description: houseData
                                          .houseList[index].description,
                                      title: houseData.houseList[index].title,
                                      isFavorite:
                                          houseData.houseList[index].isFavorite,
                                      location:
                                          houseData.houseList[index].location,
                                      price: houseData.houseList[index].price,
                                      type: houseData.houseList[index].type,
                                      area: houseData.houseList[index].area,
                                      facility:
                                          houseData.houseList[index].facility,
                                    )));
                          },
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
      ),
    );
  }
}
