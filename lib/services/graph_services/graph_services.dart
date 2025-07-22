import 'package:dioxide_mobile/models/Historical_Prices_Model.dart';
import 'package:dioxide_mobile/models/Stock_Available_Dto.dart';
import 'package:dioxide_mobile/models/historical_price.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class GraphService {
  static final _baseUrl = Platform.isAndroid
      ? 'https://10.0.2.2:7027/api/mobiledioxie'
      : 'https://127.0.0.1:7027/api/mobiledioxie';

  static const _predictionApiBaseUrl =
      'http://ec2-18-116-65-93.us-east-2.compute.amazonaws.com:8000';

  static Future<List<StockAvailableDto>> getAvailableStockSymbols() async {
    try {
      final response =
          await http.get(Uri.parse('$_baseUrl/stock/symbols/available'));
      if (response.statusCode != 200) {
        throw Exception('Failed to load available stocks');
      }

      final decoded = json.decode(response.body);

      if (decoded is List) {
        return decoded.map<StockAvailableDto>((item) {
          if (item is String) {
            // API returned ["AAPL","GOOGL"]
            return StockAvailableDto(Stock_Symbol: item);
          } else if (item is Map<String, dynamic>) {
            // API returned [{"Stock_Symbol":"AAPL"}]
            return StockAvailableDto.fromJson(item);
          } else {
            throw Exception(
                'Unexpected element type ${item.runtimeType} in available‑symbols JSON');
          }
        }).toList();
      } else {
        throw Exception(
            'Unexpected JSON structure: expected List but got ${decoded.runtimeType}');
      }
    } catch (e) {
      print('Error fetching available stocks: $e');
      return [];
    }
  }
  static Future<List<HistoricalPrice>> fetchHistoricalPrices({
      required String symbol,
      required int days,
    }) async {
      if (symbol.isEmpty || days <= 0) {
        throw ArgumentError('Invalid symbol or days parameter');
      }
      final uri = Uri.parse('$_baseUrl/get_stock_price_silver/$symbol/$days');
      final response = await http.get(uri);
      if (response.statusCode != 200) {
        throw Exception(
            'Error fetching prices: ${response.statusCode} ${response.body}');
      }

      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList
          .map((e) => HistoricalPrice.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    static Future<List<HistoricalPrice>> fetchPredictions({
    required String ticker,
  }) async {
    if (ticker.isEmpty) {
      throw ArgumentError('Ticker cannot be empty');
    }

    final uri = Uri.parse('$_predictionApiBaseUrl/api/predict/?ticker=$ticker');
    print('Fetching predictions from: $uri');

    try {
      final response = await http.get(uri);

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to load predictions: ${response.statusCode} ${response.body}');
      }

      final Map<String, dynamic> decoded = json.decode(response.body);
      final List<String> datesStr = List<String>.from(decoded['dates']);
      final List<dynamic> prices = decoded['predicted_prices'];

      if (datesStr.length != prices.length) {
        throw Exception(
            'Mismatch between dates and prices in prediction response');
      }

      List<HistoricalPrice> predictedPrices = [];
      for (int i = 0; i < datesStr.length; i++) {
        final date = DateTime.parse(datesStr[i]);
        final price = (prices[i] as num).toDouble();

        predictedPrices.add(HistoricalPrice(
          date: date,
          close: price,
          open: price,
          high: price,
          low: price,
          volume: 0,
          dividends: 0.0,
          stockSymbol: ticker,
          stockSplits: 0,
          isPrediction: true,
        ));
      }
      return predictedPrices;
    } catch (e) {
      print('Error fetching predictions: $e');
      return []; // Return empty list on error
    }
  }
    
    static Future<List<HistoricalPriceDto>> fetchHistoricalPricesByDateType({
      required String symbol,
      required String startDate,
      required String endDate,
      required String typeData,
    }) async {
      if (symbol.isEmpty || startDate.isEmpty || endDate.isEmpty) {
        throw ArgumentError('Invalid symbol or date range');
      }
      final uri = Uri.parse(
          '$_baseUrl/get_stock_price_silver/$symbol/$startDate/$endDate/$typeData');
      final response = await http.get(uri);
      if (response.statusCode != 200) {
        throw Exception(
            'Error fetching prices: ${response.statusCode} ${response.body}');
      }

      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList
          .map((e) => HistoricalPriceDto.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    static Future<List<HistoricalPrice>> fetchHistoricalPricesByDateRange(
    String stockSymbol,
    String startDate,
    String endDate,
  ) async {
    if (stockSymbol.isEmpty || startDate.isEmpty || endDate.isEmpty) {
      throw ArgumentError('Symbol and date range cannot be empty.');
    }

    final uri = Uri.parse(
        '$_baseUrl/get_stock_price_silver/$stockSymbol/$startDate/$endDate');

    try {
      final response = await http.get(uri);

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to load data: ${response.statusCode} ${response.body}');
      }

      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList
          .map((item) => HistoricalPrice.fromJson(item as Map<String, dynamic>))
          .toList();

    } catch (e) {
      print('Error fetching historical prices by date range: $e');
      rethrow;
    }
  }
}

