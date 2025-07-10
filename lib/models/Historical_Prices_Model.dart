class HistoricalPrice {
  final DateTime date;
  final double price;
  
  HistoricalPrice({required this.date, required this.price});

  String get formattedDate => '${date.month}/${date.day}';
}