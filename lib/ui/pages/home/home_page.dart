import 'package:carousel_slider/carousel_slider.dart';
import 'package:dart_rss/domain/rss_feed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vika_news/domain/provider/news_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<NewsProvider>();
    final data = model.data;
    const _height = 477.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          data?.title ?? '----',
          style: const TextStyle(
            letterSpacing: -.4,
            fontWeight: FontWeight.w700,
            fontSize: 17,
            height: 1.29,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: [
          CarouselSlider(
            carouselController: model.carouselController,
            items: List.generate(
              data?.items.length ?? 0,
              (index) => NewsItem(
                index: index,
                height: _height,
              ),
            ),
            options: CarouselOptions(
              onPageChanged: (index, reason) => model.setIndex(index),
              viewportFraction: .75,
              autoPlay: false,
              height: _height,
              scrollPhysics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              enlargeCenterPage: true,
              autoPlayAnimationDuration: const Duration(seconds: 3),
            ),
          ),
          const NewsContentItem(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => model.setUp(),
        child: const Icon(Icons.restart_alt),
      ),
    );
  }
}

class NewsItem extends StatelessWidget {
  final int index;
  final double height;
  const NewsItem({
    Key? key,
    required this.index,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = context.read<NewsProvider>().data;

    return InkWell(
      onTap: () async {
        final link = data?.items[index].link;
        if (link != null) {
          await launchUrl(Uri.parse(link));
        }
      },
      child: Image.network(
        data?.items[index].media?.contents.first.url ?? '',
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return SkeletonAnimation(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.amber,
            ),
          );
        },
      ),
    );
  }
}

class NewsContentItem extends StatelessWidget {
  const NewsContentItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<NewsProvider>();
    final data = model.data;
    final _dataIndex = model.dataIndex;

    final title = data?.items[_dataIndex].title;

    if (title == null) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SkeletonAnimation(
          child: Container(
            width: double.infinity,
            height: 45,
            color: Colors.amber,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(title),
        ],
      ),
    );
  }
}
