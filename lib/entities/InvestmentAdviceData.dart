class InvestmentAdviceData {
  final String question;
  final String adviceSummary;
  final List<String> reasoning;
  final List<String> potentialRisks;
  final String disclaimer;

  InvestmentAdviceData({
    required this.question,
    required this.adviceSummary,
    required this.reasoning,
    required this.potentialRisks,
    required this.disclaimer,
  });

  factory InvestmentAdviceData.fromJson(Map<String, dynamic> json) {
    return InvestmentAdviceData(
      question: json['question'],
      adviceSummary: json['advice_summary'],
      reasoning: List<String>.from(json['reasoning']),
      potentialRisks: List<String>.from(json['potential_risks']),
      disclaimer: json['disclaimer'],
    );
  }
}