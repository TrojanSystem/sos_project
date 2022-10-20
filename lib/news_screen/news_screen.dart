import 'package:ada_bread/news_screen/api_handler.dart';
import 'package:ada_bread/news_screen/news_model.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatefulWidget {
  NewsScreen({Key key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<TransactionModel> recips = [];
  Future<void> getNews() async {
    recips = await ApiHandler.getAllNews();
    print('this $recips');
  }

  @override
  void initState() {
    recips;
    getNews();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          recips.first.url,
        ),
      ),
    );
  }
}
