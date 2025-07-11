import 'dart:convert';
import 'dart:io';
import 'package:dioxide_mobile/models/news_article_dto.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:http/http.dart' as http;

class NewsService {
  static final String _baseUrl = Platform.isAndroid
      ? 'https://10.0.2.2:7027/api/mobiledioxie'
      : 'https://127.0.0.1:7027/api/mobiledioxie';

  static Future<List<NewsArticle>> fetchArticles(int numberOfDays) async {
    final url = Uri.parse('$_baseUrl/get_news_sentiment_by_days/$numberOfDays');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => NewsArticle.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news: ${response.statusCode}');
    }
  }
  static Future<void> openInChrome(String headline) async {
    final encodedQuery = Uri.encodeQueryComponent(headline);
    final uri = Uri.parse('https://www.google.com/search?q=$encodedQuery&btnI=1').toString();
    if (Platform.isAndroid) {
      final intent = AndroidIntent(
        action: 'action_view',
        data: uri,
        package: 'com.android.chrome',
        flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
      );

      try {
        await intent.launch();
      } catch (e) {
        throw Exception('Failed to load news');
      }
    } else {
      throw UnsupportedError('Only supported on Android');
    }
  }
}
