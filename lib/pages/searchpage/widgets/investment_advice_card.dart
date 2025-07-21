import 'package:dioxide_mobile/pages/searchpage/widgets/helpers.dart';
import 'package:dioxide_mobile/entities/InvestmentAdviceData.dart';
import 'package:flutter/material.dart';

/// A card to display investment advice.
class InvestmentAdviceCard extends StatelessWidget {
  final InvestmentAdviceData data;
  const InvestmentAdviceCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data.question,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const Divider(height: 32),
            buildSectionTitle('Advice Summary'),
            Text(data.adviceSummary, style: const TextStyle(fontStyle: FontStyle.italic)),
            const SizedBox(height: 16),
            buildSectionTitle('Reasoning'),
            ...data.reasoning.map((reason) => buildListItem(reason)),
            const SizedBox(height: 16),
            buildSectionTitle('Potential Risks'),
            ...data.potentialRisks.map((risk) => buildListItem(risk, icon: Icons.warning_amber_rounded, color: Colors.orange)),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                data.disclaimer,
                style: TextStyle(color: Colors.grey[700], fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
