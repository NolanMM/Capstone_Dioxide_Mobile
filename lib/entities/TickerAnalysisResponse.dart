import 'package:dioxide_mobile/models/search_analysis_response.dart';
import 'package:dioxide_mobile/entities/TickerAnalysisData.dart';

class TickerAnalysisResponse extends SearchAnalysisApiResponse {
  final TickerAnalysisData data;

  TickerAnalysisResponse({
    required super.type,
    required this.data,
  });

  factory TickerAnalysisResponse.fromJson(Map<String, dynamic> json) {
    return TickerAnalysisResponse(
      type: json['type'],
      data: TickerAnalysisData.fromJson(json['data']),
    );
  }
}