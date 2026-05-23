class UserProfile {
  final String id;
  String name;
  String email;
  int heightCm;
  int weightKg;
  String fitnessGoal;
  int workoutDaysPerWeek;
  final DateTime? createdAt;

  UserProfile({
    String? id,
    required this.name,
    required this.email,
    required this.heightCm,
    required this.weightKg,
    required this.fitnessGoal,
    required this.workoutDaysPerWeek,
    this.createdAt,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'heightCm': heightCm,
    'weightKg': weightKg,
    'fitnessGoal': fitnessGoal,
    'workoutDaysPerWeek': workoutDaysPerWeek,
    'createdAt':
        createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
  };

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    heightCm: json['heightCm'],
    weightKg: json['weightKg'],
    fitnessGoal: json['fitnessGoal'],
    workoutDaysPerWeek: json['workoutDaysPerWeek'],
    createdAt: json['createdAt'] != null
        ? DateTime.parse(json['createdAt'])
        : null,
  );
}
