import 'package:dioxide_mobile/models/search_analysis_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchService {
  static const String _baseUrl = 'http://ec2-18-116-65-93.us-east-2.compute.amazonaws.com:8000/api/analyze/';

  static Future<SearchAnalysisApiResponse> analyzeQuery(String query) async {
    if (query.isEmpty) {
      throw ArgumentError('Query cannot be empty.');
    }

    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'query': query}),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return SearchAnalysisApiResponse.fromJson(jsonResponse);
      } else {
        throw http.ClientException('Error: ${response.statusCode}', response.request?.url);
      }
    } on http.ClientException {
      rethrow;
    } catch (e) {
      throw Exception('Failed to make request: $e');
    }
  }
}
