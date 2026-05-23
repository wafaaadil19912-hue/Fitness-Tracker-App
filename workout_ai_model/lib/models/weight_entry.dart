class WeightEntry {
  final String id;
  final DateTime date;
  final double weight;
  final String? notes;

  WeightEntry({
    String? id,
    required this.date,
    required this.weight,
    this.notes,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date.toIso8601String(),
    'weight': weight,
    'notes': notes,
  };

  factory WeightEntry.fromJson(Map<String, dynamic> json) => WeightEntry(
    id: json['id'],
    date: DateTime.parse(json['date']),
    weight: json['weight'],
    notes: json['notes'],
  );
}
