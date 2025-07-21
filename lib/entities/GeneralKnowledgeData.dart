class GeneralKnowledgeData {
  final String conceptName;
  final String definition;
  final String importance;
  final String example;

  GeneralKnowledgeData({
    required this.conceptName,
    required this.definition,
    required this.importance,
    required this.example,
  });

  factory GeneralKnowledgeData.fromJson(Map<String, dynamic> json) {
    return GeneralKnowledgeData(
      conceptName: json['concept_name'],
      definition: json['definition'],
      importance: json['importance'],
      example: json['example'],
    );
  }
}