class Exercise {
  final String id;
  final String name;
  final String category;
  final String equipment;
  final bool isCustom;

  Exercise({
    String? id,
    required this.name,
    required this.category,
    required this.equipment,
    this.isCustom = false,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'category': category,
    'equipment': equipment,
    'isCustom': isCustom,
  };

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
    id: json['id'],
    name: json['name'],
    category: json['category'],
    equipment: json['equipment'],
    isCustom: json['isCustom'] ?? false,
  );
}

// Predefined exercises database
class PredefinedExercises {
  static List<Exercise> getExercises() {
    return [
      Exercise(name: 'Bench Press', category: 'Chest', equipment: 'Barbell'),
      Exercise(
        name: 'Incline Bench Press',
        category: 'Chest',
        equipment: 'Barbell',
      ),
      Exercise(
        name: 'Decline Bench Press',
        category: 'Chest',
        equipment: 'Barbell',
      ),
      Exercise(
        name: 'Dumbbell Flyes',
        category: 'Chest',
        equipment: 'Dumbbells',
      ),
      Exercise(name: 'Push-ups', category: 'Chest', equipment: 'Bodyweight'),
      Exercise(name: 'Squats', category: 'Legs', equipment: 'Barbell'),
      Exercise(name: 'Leg Press', category: 'Legs', equipment: 'Machine'),
      Exercise(name: 'Lunges', category: 'Legs', equipment: 'Bodyweight'),
      Exercise(name: 'Deadlifts', category: 'Back', equipment: 'Barbell'),
      Exercise(name: 'Pull-ups', category: 'Back', equipment: 'Bar'),
      Exercise(name: 'Barbell Rows', category: 'Back', equipment: 'Barbell'),
      Exercise(name: 'Lat Pulldowns', category: 'Back', equipment: 'Machine'),
      Exercise(
        name: 'Shoulder Press',
        category: 'Shoulders',
        equipment: 'Dumbbells',
      ),
      Exercise(
        name: 'Lateral Raises',
        category: 'Shoulders',
        equipment: 'Dumbbells',
      ),
      Exercise(name: 'Bicep Curls', category: 'Arms', equipment: 'Dumbbells'),
      Exercise(name: 'Tricep Pushdowns', category: 'Arms', equipment: 'Cables'),
      Exercise(name: 'Plank', category: 'Core', equipment: 'Bodyweight'),
      Exercise(
        name: 'Russian Twists',
        category: 'Core',
        equipment: 'Bodyweight',
      ),
    ];
  }
}
