import 'dart:convert';
import 'package:http/http.dart' as http; // Import the http package for making HTTP requests
import 'package:newsline/model/news_model.dart';

class News {
  List<ArticleModel> datatobesaved = [];

  Future<void> getArticle() async {
    var response = await http.get(
      Uri.parse("https://newsapi.org/v2/top-headlines?country=us&apiKey=4861a1f91e1e43aba51447b07bbbed38"),
    );
    

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            urlToImage: element['urlToImage'],
            description: element['description'],
            url: element['url'],
          );

          datatobesaved.add(articleModel);
        }
      });
    }
  }
}


//Category news fetch

class NewsCategory {

  List<ArticleModel> datatobesaved = [];

  Future<void> getArticle(String category) async {

    var response = await http.get(
      Uri.parse("https://newsapi.org/v2/top-headlines?country=us&category=&category&apiKey=4861a1f91e1e43aba51447b07bbbed38"),
    );

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            urlToImage: element['urlToImage'],
            description: element['description'],
            url: element['url'],
          );

          datatobesaved.add(articleModel);
        }
      });
    }
  }
}



//  var response = await http.get(
//       Uri.parse("https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=4861a1f91e1e43aba51447b07bbbed38"),
//     );