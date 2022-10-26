import 'package:ada_bread/news_screen/news_detail.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'news_model.dart';

class CategoryNewsList extends StatefulWidget {
  CategoryNewsList({this.categoryNews});
  List categoryNews;
  @override
  State<CategoryNewsList> createState() => _CategoryNewsListState();
}

class _CategoryNewsListState extends State<CategoryNewsList>
    with TickerProviderStateMixin {
  bool _isLoading = false;
  AnimationController _animationController;
  Future<void> getNews() async {
    setState(() {
      _isLoading = true;
    });
    widget.categoryNews;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(microseconds: 1200));
    ;
    getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'SOS',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(text: ' '),
              TextSpan(
                  text: 'News',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(
              child: SpinKitSpinningLines(
                color: Colors.blue[800],
                size: 80.0,
                lineWidth: 2,
              ),
            )
          : SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: AnimationLimiter(
                  child: ListView.builder(
                    itemCount: widget.categoryNews.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => NewsDetail(
                              blogUrl: widget.categoryNews[index].url,
                            ),
                          ),
                        );
                      },
                      child: AnimationConfiguration.staggeredGrid(
                        position: 0,
                        duration: const Duration(milliseconds: 500),
                        columnCount: 1,
                        child: ScaleAnimation(
                          duration: const Duration(milliseconds: 900),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: FadeInAnimation(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: ClipRRect(
                                    child: FancyShimmerImage(
                                      boxFit: BoxFit.cover,
                                      imageUrl:
                                          widget.categoryNews[index].urlToImage,
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.25,
                                      errorWidget: Image.network(
                                          'https://i0.wp.com/www.dobitaobyte.com.br/wp-content/uploads/2016/02/no_image.png?ssl=1'),
                                      shimmerBaseColor: Colors.greenAccent,
                                      shimmerHighlightColor: Colors.grey,
                                      shimmerBackColor: Colors.greenAccent,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    clipBehavior: Clip.antiAlias,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    widget.categoryNews[index].title ?? ' ',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    widget.categoryNews[index].description ??
                                        ' ',
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15,
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
            ),
    );
  }
}

class NewHeadLines extends StatelessWidget {
  const NewHeadLines({
    Key key,
    @required this.categoryList,
    @required this.todaysNews,
    @required this.columnCount,
  }) : super(key: key);

  final List<TransactionModel> todaysNews;
  final int columnCount;
  final List categoryList;
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        itemCount: categoryList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => CategoryNewsList(
                    categoryNews: todaysNews,
                  ),
                ),
              );
            },
            child: AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 500),
              columnCount: columnCount,
              child: ScaleAnimation(
                duration: const Duration(milliseconds: 900),
                curve: Curves.fastLinearToSlowEaseIn,
                child: FadeInAnimation(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        ClipRRect(
                          child: Image.network(
                            '${categoryList[index]['image']}',
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(7),
                          clipBehavior: Clip.antiAlias,
                        ),
                        Text(categoryList[index]['news'],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center),
                      ],
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
