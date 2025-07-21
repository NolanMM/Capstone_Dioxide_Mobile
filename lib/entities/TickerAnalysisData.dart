class TickerAnalysisData {
  final String companyName;
  final String tickerSymbol;
  final double stockPrice;
  final int marketCap;
  final String industry;
  final String summary52Week;
  final String recommendation;
  final double confidenceScore;
  final String sentimentAnalysis;
  final List<String> keyThemes;
  final List<String> keyInsights;

  TickerAnalysisData({
    required this.companyName,
    required this.tickerSymbol,
    required this.stockPrice,
    required this.marketCap,
    required this.industry,
    required this.summary52Week,
    required this.recommendation,
    required this.confidenceScore,
    required this.sentimentAnalysis,
    required this.keyThemes,
    required this.keyInsights,
  });

  factory TickerAnalysisData.fromJson(Map<String, dynamic> json) {
    return TickerAnalysisData(
      companyName: json['company_name'],
      tickerSymbol: json['ticker_symbol'],
      stockPrice: (json['stock_price'] as num).toDouble(),
      marketCap: json['market_cap'],
      industry: json['industry'],
      summary52Week: json['summary_52_week'],
      recommendation: json['recommendation'],
      confidenceScore: (json['confidence_score'] as num).toDouble(),
      sentimentAnalysis: json['sentiment_analysis'],
      keyThemes: List<String>.from(json['key_themes']),
      keyInsights: List<String>.from(json['key_insights']),
    );
  }
}