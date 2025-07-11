class NewsArticle {
  final int id;
  final String category;
  final DateTime datetime;
  final String headline;
  final String? image;
  final String related;
  final String source;
  final String summary;
  final String url;
  final String symbol;
  final double positiveValue;
  final double negativeValue;
  final double neutralValue;

  NewsArticle({
    required this.id,
    required this.category,
    required this.datetime,
    required this.headline,
    this.image,
    required this.related,
    required this.source,
    required this.summary,
    required this.url,
    required this.symbol,
    required this.positiveValue,
    required this.negativeValue,
    required this.neutralValue,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      id: json['id'],
      category: json['category'],
      datetime: DateTime.parse(json['datetime']),
      headline: json['headline'],
      image: json['image'] != "None" ? json['image'] : null,
      related: json['related'],
      source: json['source'],
      summary: json['summary'],
      url: json['url'],
      symbol: json['symbol'],
      positiveValue: (json['positive_value'] as num).toDouble(),
      negativeValue: (json['negative_value'] as num).toDouble(),
      neutralValue: (json['neutral_value'] as num).toDouble(),
    );
  }
}
