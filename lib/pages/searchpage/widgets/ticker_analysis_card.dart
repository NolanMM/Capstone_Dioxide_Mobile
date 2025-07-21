import 'package:dioxide_mobile/pages/searchpage/widgets/helpers.dart';
import 'package:dioxide_mobile/entities/TickerAnalysisData.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TickerAnalysisCard extends StatelessWidget {
  final TickerAnalysisData data;
  const TickerAnalysisCard({super.key, required this.data});

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
            Text(
              '${data.companyName} (${data.tickerSymbol})',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(data.industry, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey)),
            const Divider(height: 32),
            buildInfoRow('Price:', '\$${data.stockPrice.toStringAsFixed(2)}'),
            buildInfoRow('Market Cap:', NumberFormat.compact().format(data.marketCap)),
            buildInfoRow('Recommendation:', data.recommendation,
                valueColor: data.recommendation == 'Buy' ? Colors.green : Colors.red),
            buildInfoRow('Sentiment:', data.sentimentAnalysis,
                valueColor: data.sentimentAnalysis == 'Bullish' ? Colors.green : Colors.orange),
            const SizedBox(height: 16),
            buildSectionTitle('52-Week Summary'),
            Text(data.summary52Week),
            const SizedBox(height: 16),
            buildSectionTitle('Key Themes'),
            ...data.keyThemes.map((theme) => buildListItem(theme)),
            const SizedBox(height: 16),
            buildSectionTitle('Key Insights'),
            ...data.keyInsights.map((insight) => buildListItem(insight)),
          ],
        ),
      ),
    );
  }
}
