import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetail extends StatefulWidget {
  final String blogUrl;

  NewsDetail({this.blogUrl});

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> with TickerProviderStateMixin {
  bool _isLoading = false;
  AnimationController _animationController;
  Future<void> getNews() async {
    setState(() {
      _isLoading = true;
    });
    widget.blogUrl;
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

    int columnCount = 1;
    final Completer<WebViewController> _controller =
        Completer<WebViewController>();
    return Scaffold(
      appBar: AppBar(
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
          : SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: WebView(
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
                initialUrl: widget.blogUrl,
              ),
            ),
    );
  }
}
