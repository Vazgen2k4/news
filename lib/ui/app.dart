import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vika_news/domain/provider/news_provider.dart';
import 'package:vika_news/ui/pages/home/home_page.dart';

class VikaNews extends StatelessWidget {
  const VikaNews({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewsProvider(),
      child: const MaterialApp(
        home:  HomePage(),
      ),
    );
  }
}