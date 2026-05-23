import 'package:flutter/material.dart';
import '../models/exercise.dart';

class ExerciseLibraryScreen extends StatefulWidget {
  const ExerciseLibraryScreen({super.key});

  @override
  State<ExerciseLibraryScreen> createState() => _ExerciseLibraryScreenState();
}

class _ExerciseLibraryScreenState extends State<ExerciseLibraryScreen> {
  List<Exercise> predefinedExercises = [];
  List<Exercise> customExercises = [];
  String searchQuery = '';
  String selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    predefinedExercises = PredefinedExercises.getExercises();
  }

  List<String> get categories => [
    'All',
    ...predefinedExercises.map((e) => e.category).toSet(),
  ];

  List<Exercise> get filteredExercises {
    final all = [...predefinedExercises, ...customExercises];
    return all.where((ex) {
      final matchesSearch =
          searchQuery.isEmpty ||
          ex.name.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesCategory =
          selectedCategory == 'All' || ex.category == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise Library'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search exercises...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final cat = categories[index];
                      return FilterChip(
                        label: Text(cat),
                        selected: selectedCategory == cat,
                        onSelected: (selected) {
                          setState(() {
                            selectedCategory = cat;
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: filteredExercises.length,
        itemBuilder: (context, index) {
          final exercise = filteredExercises[index];
          final isCustom = customExercises.contains(exercise);
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green.shade100,
                child: Icon(
                  _getIconForCategory(exercise.category),
                  color: Colors.green.shade700,
                ),
              ),
              title: Text(exercise.name),
              subtitle: Text('${exercise.category} • ${exercise.equipment}'),
              trailing: isCustom
                  ? IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          customExercises.remove(exercise);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Custom exercise deleted'),
                          ),
                        );
                      },
                    )
                  : const Icon(Icons.fitness_center, color: Colors.grey),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddCustomExerciseDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  IconData _getIconForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'chest':
        return Icons.fitness_center;
      case 'legs':
        return Icons.directions_walk;
      case 'back':
        return Icons.accessibility_new;
      case 'shoulders':
        return Icons.sports_handball;
      case 'arms':
        return Icons.sports_mma;
      case 'core':
        return Icons.self_improvement;
      default:
        return Icons.sports_gymnastics;
    }
  }

  void _showAddCustomExerciseDialog() {
    final nameController = TextEditingController();
    String category = 'Chest';
    String equipment = 'Bodyweight';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Custom Exercise'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Exercise Name'),
              autofocus: true,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: category,
              decoration: const InputDecoration(labelText: 'Category'),
              items: ['Chest', 'Legs', 'Back', 'Shoulders', 'Arms', 'Core']
                  .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                  .toList(),
              onChanged: (value) {
                category = value!;
              },
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: equipment,
              decoration: const InputDecoration(labelText: 'Equipment'),
              items:
                  [
                        'Bodyweight',
                        'Dumbbells',
                        'Barbell',
                        'Machine',
                        'Cables',
                        'Kettlebells',
                        'Other',
                      ]
                      .map((eq) => DropdownMenuItem(value: eq, child: Text(eq)))
                      .toList(),
              onChanged: (value) {
                equipment = value!;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                setState(() {
                  customExercises.add(
                    Exercise(
                      name: nameController.text,
                      category: category,
                      equipment: equipment,
                      isCustom: true,
                    ),
                  );
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Custom exercise added!')),
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
