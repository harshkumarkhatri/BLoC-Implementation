import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc_implementation/Model/newsInfo.dart';

enum NewsAction { Fetch, Delete }

class NewsBloc {
  final streamController = StreamController<List<Article>>();
  // final sinkController = StreamController();
  StreamSink<List<Article>> get newsSink => streamController.sink;
  Stream<List<Article>> get newsStream => streamController.stream;

  final eventController = StreamController<NewsAction>();
  StreamSink<NewsAction> get eventSink => eventController.sink;
  Stream<NewsAction> get eventStream => eventController.stream;

  NewsBloc() {
    eventStream.listen((event) async {
      if (event == NewsAction.Fetch) {
        try {
          var news = await getNews();
          if (news != null)
            newsSink.add(news.articles);
          else
            newsSink.addError("Something went wrong");
        } on Exception catch (e) {
          // TODO
          newsSink.addError("Something went wrong");
        }
      }
    });
  }

  Future<NewsModel> getNews() async {
    var client = http.Client();
    var newsModel;

    try {
      var response = await client.get(
          'http://newsapi.org/v2/everything?domains=wsj.com&apiKey=c78c7c0c91a1486c89f009173c0d35d2');
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        newsModel = NewsModel.fromJson(jsonMap);
      }
    } catch (Exception) {
      return newsModel;
    }

    return newsModel;
  }

  void dispose() {
    streamController.close();
    eventController.close();
  }
}
