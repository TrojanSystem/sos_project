import 'package:ada_bread/news_screen/news_detail.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'api_handler.dart';
import 'category_news_list.dart';
import 'news_model.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> with TickerProviderStateMixin {
  List category = [
    {
      'news': 'business',
      'image':
          'https://images.unsplash.com/photo-1444653614773-995cb1ef9efa?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1176&q=80'
    },
    {
      'news': 'general',
      'image':
          'https://images.unsplash.com/photo-1495020689067-958852a7765e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1169&q=80'
    },
    {
      'news': 'health',
      'image':
          'https://images.unsplash.com/photo-1618498082410-b4aa22193b38?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'
    },
    {
      'news': 'entertainment',
      'image':
          'https://plus.unsplash.com/premium_photo-1661292066895-389ccd949529?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80'
    },
    {
      'news': 'science',
      'image':
          'https://images.unsplash.com/photo-1582719471384-894fbb16e074?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80'
    },
    {
      'news': 'sports',
      'image':
          'https://images.unsplash.com/photo-1579952363873-27f3bade9f55?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80'
    },
    {
      'news': 'technology',
      'image':
          'https://images.unsplash.com/photo-1581090464777-f3220bbe1b8b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80'
    }
  ];
  List<TransactionModel> todaysNews = [];
  AnimationController _animationController;
  bool _isLoading = false;
  int columnCount = 2;
  Future<void> getNews() async {
    setState(() {
      _isLoading = true;
    });
    todaysNews = await ApiHandler.getAllNews();
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
    todaysNews;
    getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
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
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: NewHeadLines(
                          todaysNews: todaysNews,
                          columnCount: columnCount,
                          categoryList: category),
                    ),
                    Expanded(
                      flex: 7,
                      child: AnimationLimiter(
                        child: ListView.builder(
                          itemCount: todaysNews.length,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => NewsDetail(
                                    blogUrl: todaysNews[index].url,
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
                                                todaysNews[index].urlToImage,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.25,
                                            errorWidget: Image.network(
                                                'https://i0.wp.com/www.dobitaobyte.com.br/wp-content/uploads/2016/02/no_image.png?ssl=1'),
                                            shimmerBaseColor:
                                                Colors.greenAccent,
                                            shimmerHighlightColor: Colors.grey,
                                            shimmerBackColor:
                                                Colors.greenAccent,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          clipBehavior: Clip.antiAlias,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text(
                                          todaysNews[index].title ?? ' ',
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
                                          todaysNews[index].description ?? ' ',
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
                  ],
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
          ApiHandler.getAllNewsSpecific(categoryList[index]['news']);

          return GestureDetector(
            onTap: () async {
              final filteredNews = await ApiHandler.getAllNewsSpecific(
                  categoryList[index]['news']);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) =>
                      CategoryNewsList(categoryNews: filteredNews),
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
