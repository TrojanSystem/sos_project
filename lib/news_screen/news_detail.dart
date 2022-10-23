import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import '../data_storage.dart';

class NewsDetail extends StatefulWidget {
  final String images;
  final String title;
  final String description;
  final String content;

  NewsDetail({this.title, this.description, this.images, this.content});

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;

    int columnCount = 1;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(40, 53, 147, 1),
        elevation: 0,
      ),
      body: Consumer<DataStorage>(
        builder: (context, provider, child) {
          return Stack(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(40, 53, 147, 1),
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
                                child: Image.network(
                                  widget.images,
                                  fit: BoxFit.contain,
                                ),
                                clipBehavior: Clip.antiAlias,
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
                        flex: 2,
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
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                18.0, 15, 0, 15),
                                            child: Text(
                                              widget.title.toString(),
                                              style: const TextStyle(
                                                decoration: TextDecoration.none,
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              widget.description,
                                              style: const TextStyle(
                                                decoration: TextDecoration.none,
                                                fontSize: 20,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Expanded(
                                    //   flex: 2,
                                    //   child: Container(
                                    //     padding: const EdgeInsets.fromLTRB(
                                    //         0.0, 0.0, 0.0, 15.0),
                                    //     child: Padding(
                                    //       padding: const EdgeInsets.all(12.0),
                                    //       child: Text(
                                    //         ' ${widget.content}',
                                    //         softWrap: true,
                                    //         textAlign: TextAlign.justify,
                                    //         maxLines: 3,
                                    //         style:
                                    //             const TextStyle(fontSize: 15),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // )
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
              // Positioned(
              //   child: IconButton(
              //     onPressed: () {
              //       Navigator.of(context).pop();
              //     },
              //     icon: const Icon(
              //       Icons.arrow_back_ios_sharp,
              //       color: Colors.black,
              //       size: 35,
              //     ),
              //   ),
              // )
            ],
          );
        },
      ),
    );
  }
}
