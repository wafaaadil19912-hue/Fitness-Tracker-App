import 'package:flutter/material.dart';
import '../models/weight_entry.dart';
import '../widgets/weight_chart_painter.dart';
import '../services/ai_service.dart';

class ProgressTrackingScreen extends StatefulWidget {
  const ProgressTrackingScreen({super.key});

  @override
  State<ProgressTrackingScreen> createState() => _ProgressTrackingScreenState();
}

class _ProgressTrackingScreenState extends State<ProgressTrackingScreen> {
  List<WeightEntry> weightEntries = [
    WeightEntry(date: DateTime(2025, 1, 1), weight: 85.5),
    WeightEntry(date: DateTime(2025, 1, 15), weight: 84.2),
    WeightEntry(date: DateTime(2025, 2, 1), weight: 83.0),
    WeightEntry(date: DateTime(2025, 2, 15), weight: 82.1),
    WeightEntry(date: DateTime(2025, 3, 1), weight: 81.5),
  ];

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Progress Tracking')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Weight Progress',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: _showAddWeightDialog,
                        icon: const Icon(Icons.add),
                        label: const Text('Add Entry'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: weightEntries.isEmpty
                        ? const Center(
                            child: Text(
                              'No data yet. Add your first weight entry!',
                            ),
                          )
                        : CustomPaint(
                            painter: WeightChartPainter(entries: weightEntries),
                            size: const Size(double.infinity, 200),
                          ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Recent Entries',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...weightEntries.reversed.take(5).map((entry) {
                    return ListTile(
                      leading: const Icon(Icons.monitor_weight),
                      title: Text('${entry.weight.toStringAsFixed(1)} kg'),
                      subtitle: Text(_formatDate(entry.date)),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            weightEntries.remove(entry);
                          });
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // ==========================================
          // FIXED: AI COACH SUGGESTIONS CARD
          // Dark background with LIGHT text for contrast
          // ==========================================
          FutureBuilder<String>(
            future: AIService.getImprovementSuggestions(
              goal: 'Gain muscle',
              recentWorkouts: [],
              totalWorkoutsThisWeek: 3,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                );
              }

              if (snapshot.hasError) {
                return Card(
                  color: Colors.red.shade100,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Failed to load suggestions. Please try again.',
                      style: TextStyle(color: Colors.red.shade900),
                    ),
                  ),
                );
              }

              // FIXED: Dark background with white text for clear contrast
              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF1B5E20), // Dark Green
                        Color(0xFF0D5302), // Very Dark Green
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header with icon
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.auto_awesome,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              '🤖 AI COACH SAYS',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Main suggestion text - WHITE for contrast
                        Text(
                          snapshot.data ??
                              'Keep up the great work! Consistency is key to achieving your fitness goals.',
                          style: const TextStyle(
                            fontSize: 14,
                            color:
                                Colors.white, // WHITE text on dark background
                            height: 1.5,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Decorative divider
                        Container(
                          height: 1,
                          color: Colors.white.withOpacity(0.3),
                        ),

                        const SizedBox(height: 10),

                        // Motivational footer
                        Row(
                          children: [
                            Icon(
                              Icons.favorite,
                              color: Colors.red.shade300,
                              size: 14,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Stay consistent! You\'re making progress 💪',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white.withOpacity(0.8),
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showAddWeightDialog() {
    final weightController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Weight Entry'),
        content: TextField(
          controller: weightController,
          decoration: const InputDecoration(
            labelText: 'Weight (kg)',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final weight = double.tryParse(weightController.text);
              if (weight != null && weight > 0) {
                setState(() {
                  weightEntries.add(
                    WeightEntry(date: DateTime.now(), weight: weight),
                  );
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Weight entry added!')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please enter a valid weight')),
                );
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
