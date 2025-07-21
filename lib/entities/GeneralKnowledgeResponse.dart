import 'package:dioxide_mobile/entities/GeneralKnowledgeData.dart';
import 'package:dioxide_mobile/models/search_analysis_response.dart';

class GeneralKnowledgeResponse extends SearchAnalysisApiResponse {
  final GeneralKnowledgeData data;

  GeneralKnowledgeResponse({
    required super.type,
    required this.data,
  });

  factory GeneralKnowledgeResponse.fromJson(Map<String, dynamic> json) {
    return GeneralKnowledgeResponse(
      type: json['type'],
      data: GeneralKnowledgeData.fromJson(json['data']),
    );
  }
}