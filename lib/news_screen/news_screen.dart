import 'package:ada_bread/news_screen/api_handler.dart';
import 'package:ada_bread/news_screen/news_detail.dart';
import 'package:ada_bread/news_screen/news_model.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> with TickerProviderStateMixin {
  List<TransactionModel> recips = [];
  AnimationController _animationController;
  Animation<double> _animation;
  bool _isLoading = false;
  int columnCount = 2;
  Future<void> getNews() async {
    setState(() {
      _isLoading = true;
    });
    recips = await ApiHandler.getAllNews();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(microseconds: 1200));
    recips;
    getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _isLoading
          ?
          // const Center(
          //         child: CircularProgressIndicator(),
          //       )
          Center(
              child: SpinKitSpinningLines(
                color: Colors.blue[800],
                size: 80.0,
                lineWidth: 2,
              ),
            )
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromRGBO(40, 53, 147, 1),
                    const Color.fromRGBO(40, 53, 147, 1).withOpacity(0.9)
                  ],
                ),
              ),
              child: AnimationLimiter(
                child: GridView.count(
                  physics: const AlwaysScrollableScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  padding:
                      EdgeInsets.fromLTRB(_w / 60, _w / 30, _w / 60, _w / 60),
                  crossAxisCount: columnCount,
                  children: List.generate(
                    recips.length,
                    (int index) {
                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        duration: const Duration(milliseconds: 500),
                        columnCount: columnCount,
                        child: ScaleAnimation(
                          duration: const Duration(milliseconds: 900),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            child: Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: GridTile(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (ctx) => NewsDetail(
                                          title: recips[index].title,
                                          description:
                                              recips[index].description,
                                          images: recips[index].urlToImage,
                                          content: recips[index].content,
                                        ),
                                      ));
                                    },
                                    child: FancyShimmerImage(
                                      boxFit: BoxFit.contain,
                                      imageUrl: recips[index].urlToImage,
                                      errorWidget: Image.network(
                                          'https://i0.wp.com/www.dobitaobyte.com.br/wp-content/uploads/2016/02/no_image.png?ssl=1'),
                                      shimmerBaseColor: Colors.greenAccent,
                                      shimmerHighlightColor: Colors.grey,
                                      shimmerBackColor: Colors.greenAccent,
                                    ),
                                  ),
                                  footer: GridTileBar(
                                    backgroundColor: Colors.transparent,
                                    title: Text(
                                      recips[index].title,
                                      style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 15,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w900,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              margin: EdgeInsets.only(
                                  bottom: _w / 30,
                                  left: _w / 30,
                                  right: _w / 30),
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
