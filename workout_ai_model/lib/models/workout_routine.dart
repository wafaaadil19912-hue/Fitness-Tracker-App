class WorkoutRoutine {
  final String id;
  final String name;
  final String day;
  final List<WorkoutExercise> exercises;
  final DateTime? completedDate;

  WorkoutRoutine({
    String? id,
    required this.name,
    required this.day,
    required this.exercises,
    this.completedDate,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'day': day,
        'exercises': exercises.map((e) => e.toJson()).toList(),
        'completedDate': completedDate?.toIso8601String(),
      };

  factory WorkoutRoutine.fromJson(Map<String, dynamic> json) => WorkoutRoutine(
        id: json['id'],
        name: json['name'],
        day: json['day'],
        exercises: (json['exercises'] as List)
            .map((e) => WorkoutExercise.fromJson(e))
            .toList(),
        completedDate: json['completedDate'] != null
            ? DateTime.parse(json['completedDate'])
            : null,
      );
}

class WorkoutExercise {
  final String name;
  final int sets;
  final int reps;
  final int? duration;
  int? actualSets;
  int? actualReps;
  bool isCompleted;

  WorkoutExercise({
    required this.name,
    required this.sets,
    required this.reps,
    this.duration,
    this.actualSets,
    this.actualReps,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'sets': sets,
        'reps': reps,
        'duration': duration,
        'actualSets': actualSets,
        'actualReps': actualReps,
        'isCompleted': isCompleted,
      };

  factory WorkoutExercise.fromJson(Map<String, dynamic> json) =>
      WorkoutExercise(
        name: json['name'],
        sets: json['sets'],
        reps: json['reps'],
        duration: json['duration'],
        actualSets: json['actualSets'],
        actualReps: json['actualReps'],
        isCompleted: json['isCompleted'] ?? false,
      );
}
