class StockAvailableDto {
  final String Stock_Symbol;

  StockAvailableDto({required this.Stock_Symbol});
  Map<String, dynamic> toJson() {
    return {
      'Stock_Symbol': Stock_Symbol,
    };
  }
  factory StockAvailableDto.fromJson(Map<String, dynamic> json) {
    return StockAvailableDto(
      Stock_Symbol: json['Stock_Symbol'] as String,
    );
  }
  @override
  String toString() {
    return 'StockAvailableDto(Stock_Symbol: $Stock_Symbol)';
  }
}