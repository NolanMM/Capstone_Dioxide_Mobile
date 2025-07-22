class HistoricalPrice {
  final DateTime date;
  final double open;
  final double high;
  final double low;
  final double close;
  final int volume;
  final double dividends;
  final String stockSymbol;
  final int stockSplits;
  final bool isPrediction;

  HistoricalPrice({
    required this.date,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
    required this.dividends,
    required this.stockSymbol,
    required this.stockSplits,
    this.isPrediction = false,
  });

  double get price => close;

  String get formattedDate => '${date.month}/${date.day}';

  factory HistoricalPrice.fromJson(Map<String, dynamic> json) {
    return HistoricalPrice(
      date: DateTime.parse(json['date'] as String),
      open: (json['open'] as num).toDouble(),
      high: (json['high'] as num).toDouble(),
      low: (json['low'] as num).toDouble(),
      close: (json['close'] as num).toDouble(),
      volume: (json['volume'] as num).toInt(),
      dividends: (json['dividends'] as num).toDouble(),
      stockSymbol: json['stock_Symbol'] as String,
      stockSplits: (json['stock_Splits'] as num).toInt(),
      isPrediction: json['isPrediction'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'open': open,
        'high': high,
        'low': low,
        'close': close,
        'volume': volume,
        'dividends': dividends,
        'stock_Symbol': stockSymbol,
        'stock_Splits': stockSplits,
        'isPrediction': isPrediction,
      };
}
