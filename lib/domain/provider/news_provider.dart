import 'package:carousel_slider/carousel_controller.dart';
import 'package:dart_rss/dart_rss.dart';
import 'package:flutter/material.dart';
import 'package:vika_news/domain/api/news_api.dart';

class NewsProvider extends ChangeNotifier {
  RssFeed? _data;
  RssFeed? get data => _data;

  int _dataIndex = 0;
  int get dataIndex => _dataIndex;

  CarouselController carouselController = CarouselController();

  NewsProvider() {
    setUp();
  }

  setIndex(int value) {
    _dataIndex = value;
    notifyListeners();
  }

  void setUp() async {
    _data = await NewsApi.getRsa();

    print(_data?.dc?.date);
    notifyListeners();
  }
}
