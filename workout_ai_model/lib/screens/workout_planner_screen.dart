import 'package:flutter/material.dart';
import '../models/workout_routine.dart';
import '../services/ai_service.dart';

class WorkoutPlannerScreen extends StatefulWidget {
  const WorkoutPlannerScreen({super.key});

  @override
  State<WorkoutPlannerScreen> createState() => _WorkoutPlannerScreenState();
}

class _WorkoutPlannerScreenState extends State<WorkoutPlannerScreen> {
  List<WorkoutRoutine> routines = [
    WorkoutRoutine(
      name: 'Chest Day',
      day: 'Monday',
      exercises: [
        WorkoutExercise(
            name: 'Bench Press', sets: 4, reps: 10, isCompleted: false),
        WorkoutExercise(
            name: 'Incline Dumbbell Press',
            sets: 3,
            reps: 12,
            isCompleted: false),
        WorkoutExercise(
            name: 'Push-ups', sets: 3, reps: 15, isCompleted: false),
      ],
    ),
    WorkoutRoutine(
      name: 'Leg Day',
      day: 'Tuesday',
      exercises: [
        WorkoutExercise(name: 'Squats', sets: 4, reps: 8, isCompleted: false),
        WorkoutExercise(
            name: 'Leg Press', sets: 3, reps: 12, isCompleted: false),
        WorkoutExercise(name: 'Lunges', sets: 3, reps: 12, isCompleted: false),
      ],
    ),
    WorkoutRoutine(
      name: 'Back & Biceps',
      day: 'Thursday',
      exercises: [
        WorkoutExercise(name: 'Pull-ups', sets: 3, reps: 8, isCompleted: false),
        WorkoutExercise(
            name: 'Barbell Rows', sets: 4, reps: 10, isCompleted: false),
        WorkoutExercise(
            name: 'Bicep Curls', sets: 3, reps: 12, isCompleted: false),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Planner'),
        actions: [
          IconButton(
            icon: const Icon(Icons.auto_awesome),
            onPressed: () {
              _showAIGenerateDialog();
            },
            tooltip: 'AI Generate Plan',
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: routines.length,
        itemBuilder: (context, index) {
          final routine = routines[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ExpansionTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green.shade100,
                child: Text(routine.day[0]),
              ),
              title: Text(routine.name),
              subtitle: Text('${routine.exercises.length} exercises'),
              children: [
                ...routine.exercises.asMap().entries.map((entry) {
                  final exerciseIndex = entry.key;
                  final ex = entry.value;
                  return ListTile(
                    leading: const Icon(Icons.fitness_center),
                    title: Text(ex.name),
                    subtitle: Text(
                      ex.duration != null
                          ? '${ex.duration} sec'
                          : '${ex.sets} sets x ${ex.reps} reps',
                    ),
                    trailing: Checkbox(
                      value: ex.isCompleted,
                      onChanged: (val) {
                        setState(() {
                          routines[index].exercises[exerciseIndex].isCompleted =
                              val ?? false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                '${ex.name} marked as ${val == true ? "completed" : "incomplete"}'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  );
                }),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          _showLogWorkoutDialog(routine, index);
                        },
                        icon: const Icon(Icons.edit_note),
                        label: const Text('Log Workout'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            for (var exercise in routines[index].exercises) {
                              exercise.isCompleted = true;
                            }
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Workout marked as completed!')),
                          );
                        },
                        icon: const Icon(Icons.check),
                        label: const Text('Complete All'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddRoutineDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showLogWorkoutDialog(WorkoutRoutine routine, int routineIndex) {
    final Map<int, TextEditingController> setsControllers = {};
    final Map<int, TextEditingController> repsControllers = {};

    for (int i = 0; i < routine.exercises.length; i++) {
      setsControllers[i] =
          TextEditingController(text: routine.exercises[i].sets.toString());
      repsControllers[i] =
          TextEditingController(text: routine.exercises[i].reps.toString());
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Log ${routine.name}'),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Record your performance:'),
              const SizedBox(height: 16),
              ...routine.exercises.asMap().entries.map((entry) {
                final index = entry.key;
                final ex = entry.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(ex.name,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: setsControllers[index]!,
                              decoration: const InputDecoration(
                                labelText: 'Sets',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: repsControllers[index]!,
                              decoration: const InputDecoration(
                                labelText: 'Reps',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              for (int i = 0; i < routine.exercises.length; i++) {
                final setsText = setsControllers[i]!.text;
                final repsText = repsControllers[i]!.text;
                routine.exercises[i].actualSets = int.tryParse(setsText);
                routine.exercises[i].actualReps = int.tryParse(repsText);
                routine.exercises[i].isCompleted = true;
              }
              setState(() {});
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Workout logged successfully!')),
              );
            },
            child: const Text('Save Log'),
          ),
        ],
      ),
    );
  }

  void _showAddRoutineDialog() {
    final nameController = TextEditingController();
    String selectedDay = 'Monday';
    final List<WorkoutExercise> newExercises = [];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Add New Routine'),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Routine Name'),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedDay,
                  decoration: const InputDecoration(labelText: 'Day'),
                  items: [
                    'Monday',
                    'Tuesday',
                    'Wednesday',
                    'Thursday',
                    'Friday',
                    'Saturday',
                    'Sunday'
                  ]
                      .map((day) =>
                          DropdownMenuItem(value: day, child: Text(day)))
                      .toList(),
                  onChanged: (value) {
                    selectedDay = value!;
                  },
                ),
                const SizedBox(height: 12),
                const Text('Exercises:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Container(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: newExercises.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(newExercises[index].name),
                        subtitle: Text(
                            '${newExercises[index].sets} sets x ${newExercises[index].reps} reps'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              newExercises.removeAt(index);
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () =>
                      _showAddExerciseDialog(context, setState, newExercises),
                  icon: const Icon(Icons.add),
                  label: const Text('Add Exercise'),
                ),
              ],
            ),
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
                    routines.add(WorkoutRoutine(
                      name: nameController.text,
                      day: selectedDay,
                      exercises: List.from(newExercises),
                    ));
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Routine added!')),
                  );
                }
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddExerciseDialog(BuildContext context, StateSetter setState,
      List<WorkoutExercise> exercises) {
    final nameController = TextEditingController();
    final setsController = TextEditingController(text: '3');
    final repsController = TextEditingController(text: '10');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Exercise'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Exercise Name'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: setsController,
              decoration: const InputDecoration(labelText: 'Sets'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: repsController,
              decoration: const InputDecoration(labelText: 'Reps'),
              keyboardType: TextInputType.number,
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
                  exercises.add(WorkoutExercise(
                    name: nameController.text,
                    sets: int.tryParse(setsController.text) ?? 3,
                    reps: int.tryParse(repsController.text) ?? 10,
                  ));
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showAIGenerateDialog() {
    String selectedGoal = 'Gain muscle';
    int selectedDays = 4;
    int selectedDuration = 4; // weeks or months
    String selectedTimeUnit = 'weeks';
    String selectedLevel = 'intermediate';
    bool isLoading = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('🤖 AI Workout Plan Generator'),
          content: isLoading
              ? const SizedBox(
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('AI is creating your personalized plan...'),
                    ],
                  ),
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Get a personalized workout plan from AI',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedGoal,
                      decoration:
                          const InputDecoration(labelText: '🎯 Fitness Goal'),
                      items: const [
                        DropdownMenuItem(
                            value: 'Lose weight', child: Text('Lose weight')),
                        DropdownMenuItem(
                            value: 'Gain muscle', child: Text('Gain muscle')),
                        DropdownMenuItem(
                            value: 'Maintain', child: Text('Maintain')),
                      ],
                      onChanged: (value) {
                        setState(() => selectedGoal = value!);
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<int>(
                      value: selectedDays,
                      decoration:
                          const InputDecoration(labelText: '📅 Days per week'),
                      items: [3, 4, 5, 6].map((days) {
                        return DropdownMenuItem(
                            value: days, child: Text('$days days'));
                      }).toList(),
                      onChanged: (value) {
                        setState(() => selectedDays = value!);
                      },
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<int>(
                            value: selectedDuration,
                            decoration:
                                const InputDecoration(labelText: '⏱️ Duration'),
                            items: [2, 4, 6, 8, 12].map((duration) {
                              return DropdownMenuItem(
                                  value: duration, child: Text('$duration'));
                            }).toList(),
                            onChanged: (value) {
                              setState(() => selectedDuration = value!);
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedTimeUnit,
                            decoration:
                                const InputDecoration(labelText: 'Unit'),
                            items: const [
                              DropdownMenuItem(
                                  value: 'weeks', child: Text('Weeks')),
                              DropdownMenuItem(
                                  value: 'months', child: Text('Months')),
                            ],
                            onChanged: (value) {
                              setState(() => selectedTimeUnit = value!);
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: selectedLevel,
                      decoration:
                          const InputDecoration(labelText: '💪 Fitness Level'),
                      items: const [
                        DropdownMenuItem(
                            value: 'beginner', child: Text('Beginner')),
                        DropdownMenuItem(
                            value: 'intermediate', child: Text('Intermediate')),
                        DropdownMenuItem(
                            value: 'advanced', child: Text('Advanced')),
                      ],
                      onChanged: (value) {
                        setState(() => selectedLevel = value!);
                      },
                    ),
                  ],
                ),
          actions: isLoading
              ? []
              : [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      setState(() => isLoading = true);

                      final aiPlan = await AIService.generateWorkoutPlan(
                        goal: selectedGoal,
                        daysPerWeek: selectedDays,
                        fitnessLevel: selectedLevel,
                        duration: selectedDuration,
                        durationUnit: selectedTimeUnit,
                      );

                      setState(() => isLoading = false);
                      Navigator.pop(context);

                      _showAIPlanDialog(aiPlan, selectedGoal, selectedDays);
                    },
                    icon: const Icon(Icons.auto_awesome),
                    label: const Text('Generate with AI'),
                  ),
                ],
        ),
      ),
    );
  }

  void _showAIPlanDialog(String plan, String goal, int daysPerWeek) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: double.maxFinite,
          constraints: const BoxConstraints(maxHeight: 600),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.auto_awesome, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Your AI Generated Plan',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: SelectableText(
                    plan,
                    style: const TextStyle(height: 1.5),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Plan saved! You can create routines manually.')),
                        );
                      },
                      icon: const Icon(Icons.save),
                      label: const Text('Save Plan'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
