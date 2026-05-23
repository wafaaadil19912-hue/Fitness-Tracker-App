import 'dart:convert';

class AIService {
  static Future<String> generateWorkoutPlan({
    required String goal,
    required int daysPerWeek,
    String equipment = 'Basic gym equipment',
    int durationMinutes = 45,
    String? fitnessLevel,
    int duration = 4,
    String durationUnit = 'weeks',
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return _getMockWorkoutPlan(goal, daysPerWeek, duration, durationUnit);
  }

  static String _getMockWorkoutPlan(
      String goal, int daysPerWeek, int duration, String unit) {
    if (goal == 'Gain muscle') {
      return '''
╔══════════════════════════════════════════════════════════════╗
║     💪 YOUR PERSONALIZED $duration $unit MUSCLE GAIN PLAN    ║
║              Based on $daysPerWeek days/week                 ║
╚══════════════════════════════════════════════════════════════╝

📅 **WEEK 1-2: FOUNDATION PHASE**
Focus on form and building neural connections

**Day 1 - Push Day**
• Bench Press: 3 sets × 10-12 reps
• Shoulder Press: 3 sets × 10-12 reps
• Tricep Pushdowns: 3 sets × 12-15 reps

**Day 2 - Pull Day**  
• Lat Pulldowns: 3 sets × 10-12 reps
• Seated Rows: 3 sets × 10-12 reps
• Bicep Curls: 3 sets × 12 reps

**Day 3 - Leg Day**
• Goblet Squats: 3 sets × 12 reps
• Leg Press: 3 sets × 12 reps
• Calf Raises: 3 sets × 15 reps

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📅 **WEEK 3-4: BUILDING PHASE**
Increase intensity and volume

**Day 1 - Push Day**
• Bench Press: 4 sets × 8-10 reps
• Incline Press: 3 sets × 10 reps
• Dips: 3 sets × 8-10 reps
• Lateral Raises: 3 sets × 12 reps

**Day 2 - Pull Day**
• Pull-ups: 4 sets × 6-8 reps
• Barbell Rows: 4 sets × 8-10 reps
• Face Pulls: 3 sets × 15 reps
• Hammer Curls: 3 sets × 10 reps

**Day 3 - Leg Day**
• Squats: 4 sets × 8-10 reps
• Romanian Deadlifts: 4 sets × 10 reps
• Walking Lunges: 3 sets × 12/leg
• Leg Extensions: 3 sets × 12 reps

${unit == 'months' ? '''
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📅 **WEEK 5-8: INTENSIFICATION PHASE** (Month 2)

**Day 1 - Heavy Push Day**
• Bench Press: 5 sets × 5 reps (heavy)
• Overhead Press: 4 sets × 6-8 reps
• Close Grip Bench: 3 sets × 8 reps

**Day 2 - Heavy Pull Day**
• Deadlifts: 5 sets × 5 reps
• Weighted Pull-ups: 4 sets × 6 reps
• Pendlay Rows: 4 sets × 6-8 reps

**Day 3 - Heavy Leg Day**
• Back Squats: 5 sets × 5 reps
• Front Squats: 3 sets × 8 reps
• Hip Thrusts: 3 sets × 10 reps

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📅 **WEEK 9-12: PEAKING PHASE** (Month 3)

**Day 1 - Push Day**
• Bench Press: 4 sets × 3-5 reps (max effort)
• Incline DB: 3 sets × 6-8 reps
• Dips (weighted): 3 sets × 6-8 reps

**Day 2 - Pull Day**
• Weighted Pull-ups: 4 sets × 5 reps
• T-Bar Rows: 4 sets × 6-8 reps
• Barbell Curls: 3 sets × 8 reps

**Day 3 - Leg Day**
• Squats: 4 sets × 5 reps (heavy)
• Deadlifts: 4 sets × 5 reps
• Bulgarian Split Squats: 3 sets × 8/leg
''' : ''}

🎯 **NUTRITION GUIDELINES FOR MUSCLE GAIN**
• Eat 300-500 calories above maintenance
• Consume 1.6-2.2g protein per kg body weight
• Carbs around workouts for energy

📊 **PROGRESS TRACKING**
• Take progress photos every 2 weeks
• Track your lifts to ensure progressive overload
• Measure arms, chest, legs monthly
''';
    } else {
      return '''
╔══════════════════════════════════════════════════════════════╗
║     🔥 YOUR PERSONALIZED $duration $unit WEIGHT LOSS PLAN    ║
║              Based on $daysPerWeek days/week                 ║
╚══════════════════════════════════════════════════════════════╝

📅 **WEEK 1-2: ADAPTATION PHASE**
Build consistency and establish habits

**Day 1 - Full Body**
• Bodyweight Squats: 3 sets × 15 reps
• Push-ups: 3 sets × 10 reps
• Lunges: 3 sets × 12/leg
• Plank: 3 sets × 30 sec

**Day 2 - Cardio Focus**
• 20 min HIIT (30 sec on/30 sec off)
• 20 min LISS cardio (walking/jogging)

**Day 3 - Strength Circuit**  
• Goblet Squats: 3 sets × 12 reps
• Dumbbell Rows: 3 sets × 12 reps
• Shoulder Press: 3 sets × 12 reps
• Bicycle Crunches: 3 sets × 20 reps

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📅 **WEEK 3-4: ACCELERATION PHASE**
Increase intensity and calorie burn

**Day 1 - HIIT Full Body**
• Burpees: 45 sec on/15 off × 4
• Mountain Climbers: 45/15 × 4
• Jump Squats: 45/15 × 4
• High Knees: 45/15 × 4

**Day 2 - Circuit Training**
• Kettlebell Swings: 15 reps
• Push-ups: 12 reps
• Walking Lunges: 12/leg
• Russian Twists: 20 reps
• Rest 60 sec, repeat 4x

**Day 3 - Cardio + Core**
• 30 min steady-state cardio
• Plank Variations: 3 min total
• Leg Raises: 3 sets × 15 reps

${unit == 'months' ? '''
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📅 **WEEK 5-8: BURN PHASE** (Month 2)

**Day 1 - Metabolic Conditioning**
• Box Jumps: 12 reps × 4
• Battle Ropes: 30 sec × 4
• Sled Pushes: 20 yards × 4
• Burpees: 10 reps × 4

**Day 2 - Superset Strength**
• Squat to Press: 12 reps × 4
• Renegade Rows: 10/arm × 4
• Thrusters: 15 reps × 4
• Rest 60 sec between supersets

**Day 3 - Endurance Cardio**
• 45 min moderate intensity cardio
• Heart rate zone 2-3 (65-75% max)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📅 **WEEK 9-12: FINAL PUSH** (Month 3)

**Day 1 - Advanced HIIT**
• Tabata: 20 sec on/10 off × 8 rounds
• 4 different exercises, 2 rounds each

**Day 2 - Complex Training**
• Barbell Complex: 6 exercises back-to-back
• Minimal rest between exercises
• Rest 2 min between rounds, repeat 4x

**Day 3 - Active Recovery**
• 60 min light activity (walking, swimming, yoga)
• Focus on mobility and stretching
''' : ''}

🥗 **NUTRITION FOR WEIGHT LOSS**
• Create 300-500 calorie deficit
• Eat 1.6-2.2g protein per kg
• Drink 3-4L water daily
• Limit processed foods and sugar

📊 **PROGRESS TRACKING**
• Weekly weigh-ins (same time/day)
• Take waist measurements
• Track energy levels and mood
''';
    }
  }

  // Other methods remain the same...
  static Future<String> getImprovementSuggestions({
    required String goal,
    required List<Map<String, dynamic>> recentWorkouts,
    required int totalWorkoutsThisWeek,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (totalWorkoutsThisWeek < 3) {
      return "🎯 **Consistency Tip:** Try to schedule your workouts at the same time each day to build a habit.\n\n💪 Even 15-minute workouts count - don't skip just because you're short on time!";
    } else {
      return "📈 **Great consistency!** Try increasing weight by 2.5kg next week.\n\n🍎 Add more protein to your post-workout meals for better recovery.";
    }
  }

  static Future<String> getDailyTip({
    required String goal,
    required int currentStreak,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final tips = {
      'Gain muscle': [
        "💪 Add 2.5kg or 1 more rep each week for progressive overload!",
        "🥩 Eat protein within 2 hours post-workout for muscle growth.",
        "😴 Sleep 7-8 hours - your muscles grow while you rest!",
      ],
      'Lose weight': [
        "🔥 HIIT burns more calories in less time - try 20 minutes!",
        "🥗 Create a 300-500 calorie deficit for steady fat loss.",
        "💧 Drink water before meals to feel fuller naturally.",
      ],
      'Maintain': [
        "⚖️ Consistency beats intensity - stay active most days!",
        "🍽️ Balance your plate: protein, carbs, and healthy fats.",
        "🎯 Set performance goals, not just appearance goals.",
      ],
    };

    final goalTips = tips[goal] ?? tips['Maintain']!;
    return goalTips[DateTime.now().day % goalTips.length];
  }

  static Future<String> getDietSuggestion({
    required String goal,
    required String mealType,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final meals = {
      'Gain muscle': {
        'breakfast': "🥚 4-egg omelet with spinach and whole grain toast",
        'lunch': "🍗 200g grilled chicken with brown rice",
        'dinner': "🥩 200g lean steak with sweet potato",
        'snack': "🥤 Protein shake with banana",
      },
      'Lose weight': {
        'breakfast': "🥣 Greek yogurt with berries",
        'lunch': "🥗 Grilled chicken salad",
        'dinner': "🐟 Baked salmon with broccoli",
        'snack': "🍎 Apple with almond butter",
      },
      'Maintain': {
        'breakfast': "🥣 Oatmeal with protein powder",
        'lunch': "🥙 Turkey and avocado wrap",
        'dinner': "🍝 Whole grain pasta with turkey",
        'snack': "🥛 Cottage cheese with berries",
      },
    };

    return meals[goal]?[mealType] ??
        "🥗 Balanced meal with lean protein and vegetables";
  }
}
