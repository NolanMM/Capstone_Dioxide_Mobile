import 'package:dioxide_mobile/models/search_analysis_response.dart';
import 'package:dioxide_mobile/entities/InvestmentAdviceData.dart';

class InvestmentAdviceResponse extends SearchAnalysisApiResponse {
  final InvestmentAdviceData data;

  InvestmentAdviceResponse({
    required super.type,
    required this.data,
  });

  factory InvestmentAdviceResponse.fromJson(Map<String, dynamic> json) {
    return InvestmentAdviceResponse(
      type: json['type'],
      data: InvestmentAdviceData.fromJson(json['data']),
    );
  }
}