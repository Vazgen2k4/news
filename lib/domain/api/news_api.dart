import 'package:dart_rss/dart_rss.dart';
import 'package:http/http.dart' as http;

class NewsApi {
  static const _path = 'https://uzreport.news/feed/rss/ru';

  static Future<RssFeed?> getRsa() async {
    try {
      final url = Uri.parse(_path);

      final reques = await http.get(url);

      return RssFeed.parse(reques.body);
    } catch (e) {
      print(e);
    }
    return null;
  }
}
