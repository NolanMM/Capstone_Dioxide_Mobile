class HistoricalPriceDto {
  final double? price;
  final String? date;
  final String? type;
  final String? stockSymbol;

  HistoricalPriceDto({
    required this.price,
    required this.date,
    required this.type,
    required this.stockSymbol,
  });

  factory HistoricalPriceDto.fromJson(Map<String, dynamic> json) {
    return HistoricalPriceDto(
      price: json['Price'] as double,
      date: json['Date'] as String,
      type: json['Type'] as String,
      stockSymbol: json['Stock_Symbol'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'Price': price,
        'Date': date,
        'Type': type,
        'Stock_Symbol': stockSymbol,
      };
}
