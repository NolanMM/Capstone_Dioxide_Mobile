import 'package:dioxide_mobile/entities/GeneralKnowledgeResponse.dart';
import 'package:dioxide_mobile/entities/InvestmentAdviceResponse.dart';
import 'package:dioxide_mobile/entities/TickerAnalysisResponse.dart';

abstract class SearchAnalysisApiResponse {
  final String type;

  SearchAnalysisApiResponse({required this.type});

  factory SearchAnalysisApiResponse.fromJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case 'ticker_analysis':
        return TickerAnalysisResponse.fromJson(json);
      case 'general_knowledge':
        return GeneralKnowledgeResponse.fromJson(json);
      case 'investment_advice':
        return InvestmentAdviceResponse.fromJson(json);
      default:
        throw ArgumentError('Unknown response type: ${json['type']}');
    }
  }
}