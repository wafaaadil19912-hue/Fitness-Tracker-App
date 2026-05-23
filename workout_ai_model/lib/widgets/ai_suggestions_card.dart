import 'package:flutter/material.dart';

class AiSuggestionsCard extends StatelessWidget {
  const AiSuggestionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.auto_awesome, color: Colors.green.shade700),
                const SizedBox(width: 8),
                const Text(
                  'AI Suggestions',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Dynamic suggestion based on goal
            const Text(
              '🤖 Your weekly insights:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),

            const BulletPoint(
              text: 'Your weight is trending down - great progress!',
            ),
            const SizedBox(height: 4),
            const BulletPoint(
              text: 'Consider increasing protein intake to preserve muscle',
            ),
            const SizedBox(height: 4),
            const BulletPoint(
              text: 'Add one more leg day per week for better balance',
            ),

            const SizedBox(height: 16),

            // Diet suggestion card
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.restaurant, color: Colors.orange),
                      const SizedBox(width: 12),
                      const Text(
                        'Today\'s Meal Suggestion',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '🥗 High protein lunch: Grilled chicken breast with quinoa and roasted vegetables',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '💪 Post-workout snack: Greek yogurt with berries and a scoop of protein powder',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Strength improvement suggestion
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.trending_up, color: Colors.blue.shade700),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Strength Tip',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Your bench press volume increased by 15% this week. Keep it up!',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;
  const BulletPoint({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('• ', style: TextStyle(fontSize: 14)),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
      ],
    );
  }
}
