import 'package:flutter/material.dart';
import '../models/user_profile.dart';
import '../services/ai_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserProfile userProfile;
  int workoutStreak = 0;

  @override
  void initState() {
    super.initState();
    userProfile = UserProfile(
      name: 'Wafa Aadil',
      email: 'wafaadil19912@gmail.com',
      heightCm: 152,
      weightKg: 48,
      fitnessGoal: 'Gain muscle',
      workoutDaysPerWeek: 4,
    );
    _loadWorkoutStreak();
  }

  Future<void> _loadWorkoutStreak() async {
    setState(() {
      workoutStreak = 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.green,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    userProfile.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    userProfile.email,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Physical Stats',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    leading: const Icon(Icons.height),
                    title: const Text('Height'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('${userProfile.heightCm} cm'),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _showEditHeightDialog(),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.monitor_weight),
                    title: const Text('Weight'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('${userProfile.weightKg} kg'),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _showEditWeightDialog(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Fitness Preferences',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    leading: const Icon(Icons.flag),
                    title: const Text('Goal'),
                    trailing: DropdownButton<String>(
                      value: userProfile.fitnessGoal,
                      items: const [
                        DropdownMenuItem(
                          value: 'Lose weight',
                          child: Text('Lose weight'),
                        ),
                        DropdownMenuItem(
                          value: 'Gain muscle',
                          child: Text('Gain muscle'),
                        ),
                        DropdownMenuItem(
                          value: 'Maintain',
                          child: Text('Maintain'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            userProfile.fitnessGoal = value;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Goal updated to ${userProfile.fitnessGoal}',
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.calendar_month),
                    title: const Text('Workout Days/Week'),
                    trailing: DropdownButton<int>(
                      value: userProfile.workoutDaysPerWeek,
                      items: [3, 4, 5, 6].map((days) {
                        return DropdownMenuItem(
                          value: days,
                          child: Text('$days days'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            userProfile.workoutDaysPerWeek = value;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // ==========================================
          // FIXED: AI Daily Tip Card - HIGH CONTRAST
          // Dark background with WHITE text for readability
          // ==========================================
          FutureBuilder<String>(
            future: AIService.getDailyTip(
              goal: userProfile.fitnessGoal,
              currentStreak: workoutStreak,
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

              // HIGH CONTRAST CARD: Dark background + White/Light text
              return Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF1565C0), // Deep Blue
                      Color(0xFF0D47A1), // Darker Blue
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.shade200,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Row(
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
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '✨ AI DAILY TIP',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.white70,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              snapshot.data ??
                                  'Stay consistent with your workouts!',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white, // WHITE text for contrast
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showEditHeightDialog() {
    final controller = TextEditingController(
      text: userProfile.heightCm.toString(),
    );
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Height'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Height (cm)'),
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
              final newHeight = int.tryParse(controller.text);
              if (newHeight != null && newHeight > 0 && newHeight < 300) {
                setState(() {
                  userProfile.heightCm = newHeight;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Height updated!')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter a valid height (1-300 cm)'),
                  ),
                );
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showEditWeightDialog() {
    final controller = TextEditingController(
      text: userProfile.weightKg.toString(),
    );
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Weight'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Weight (kg)'),
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
              final newWeight = int.tryParse(controller.text);
              if (newWeight != null && newWeight > 0 && newWeight < 500) {
                setState(() {
                  userProfile.weightKg = newWeight;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Weight updated!')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter a valid weight (1-500 kg)'),
                  ),
                );
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
