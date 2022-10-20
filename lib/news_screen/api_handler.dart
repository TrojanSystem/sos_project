import 'dart:convert';

import 'package:ada_bread/news_screen/news_model.dart';
import 'package:http/http.dart' as http;

class ApiHandler {
  static Future<List<TransactionModel>> getAllNews() async {
    List _temp = [];
    var response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=1ccec22d7ae44698aa58a89834513065'));

    var data = jsonDecode(response.body);
    if (data['status'] == "ok") {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      for (var i in data['articles']) {
        _temp.add(i);
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
    return TransactionModel.recipesFromSnapshot(_temp);
  }
}
