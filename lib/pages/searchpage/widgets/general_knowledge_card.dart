import 'package:dioxide_mobile/entities/GeneralKnowledgeData.dart';
import 'package:dioxide_mobile/pages/searchpage/widgets/helpers.dart';
import 'package:flutter/material.dart';

/// A card to display general knowledge data.
class GeneralKnowledgeCard extends StatelessWidget {
  final GeneralKnowledgeData data;
  const GeneralKnowledgeCard({super.key, required this.data});

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
            Text(data.conceptName,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const Divider(height: 32),
            buildSectionTitle('Definition'),
            Text(data.definition),
            const SizedBox(height: 16),
            buildSectionTitle('Importance'),
            Text(data.importance),
            const SizedBox(height: 16),
            buildSectionTitle('Example'),
            Text(data.example),
          ],
        ),
      ),
    );
  }
}
