import 'package:flutter/material.dart';

class DailyTipCard extends StatefulWidget {
  const DailyTipCard({super.key});

  @override
  State<DailyTipCard> createState() => _DailyTipCardState();
}

class _DailyTipCardState extends State<DailyTipCard> {
  final List<Map<String, String>> tips = [
    {
      'title': '💡 Rest Day Recovery',
      'tip':
          'Rest day tomorrow! Focus on mobility and stretching for better recovery.',
      'icon': '😴',
    },
    {
      'title': '💧 Hydration Reminder',
      'tip':
          'Drink water before, during, and after your workout to maintain performance.',
      'icon': '💧',
    },
    {
      'title': '🍽️ Pre-Workout Fuel',
      'tip':
          'Eat a banana or small carb snack 30 minutes before training for energy.',
      'icon': '🍌',
    },
    {
      'title': '🎯 Form Focus',
      'tip': 'Quality over quantity! Focus on proper form to prevent injuries.',
      'icon': '🎯',
    },
    {
      'title': '📈 Progressive Overload',
      'tip':
          'Try adding 2.5kg or one extra rep each week to keep making progress.',
      'icon': '📈',
    },
    {
      'title': '😴 Sleep Matters',
      'tip':
          'Aim for 7-9 hours of sleep - that\'s when your muscles actually grow!',
      'icon': '😴',
    },
  ];

  late Map<String, String> currentTip;

  @override
  void initState() {
    super.initState();
    _getRandomTip();
  }

  void _getRandomTip() {
    final randomIndex = DateTime.now().day % tips.length;
    currentTip = tips[randomIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(currentTip['icon']!, style: const TextStyle(fontSize: 24)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    currentTip['title']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh, size: 20),
                  onPressed: () {
                    setState(() {
                      _getRandomTip();
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('New tip loaded!')),
                    );
                  },
                  tooltip: 'New tip',
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              currentTip['tip']!,
              style: const TextStyle(fontSize: 14, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
