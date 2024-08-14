import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UploadScreen extends StatelessWidget {
  final List<Map<String, dynamic>> healthTips = [
    {"tip": "Stay hydrated: Drink at least 8 glasses of water a day to maintain hydration."},
    {"tip": "Eat a balanced diet: Include a variety of fruits, vegetables, lean proteins, and whole grains in your diet."},
    {"tip": "Exercise regularly: Aim for at least 150 minutes of moderate aerobic activity or 75 minutes of vigorous activity per week."},
    {"tip": "Get enough sleep: Aim for 7-9 hours of quality sleep each night."},
    {"tip": "Practice portion control: Be mindful of portion sizes to avoid overeating."},
    {"tip": "Reduce sugar intake: Limit your consumption of sugary foods and beverages."},
    {"tip": "Avoid processed foods: Choose whole, unprocessed foods over processed options."},
    {"tip": "Incorporate fiber: Eat foods high in fiber to aid digestion and keep you full longer."},
    {"tip": "Limit alcohol consumption: Drink alcohol in moderation, if at all."},
    {"tip": "Don’t skip breakfast: Start your day with a healthy breakfast to boost energy levels."},
    {"tip": "Practice mindfulness: Engage in mindfulness or meditation to reduce stress and improve mental clarity."},
    {"tip": "Maintain a healthy weight: Strive for a weight that is appropriate for your height and body type."},
    {"tip": "Get regular check-ups: Visit your healthcare provider for regular check-ups and screenings."},
    {"tip": "Protect your skin: Use sunscreen with SPF 30 or higher to protect against UV damage."},
    {"tip": "Practice good hygiene: Wash your hands regularly and maintain good personal hygiene."},
    {"tip": "Limit caffeine intake: Avoid excessive consumption of caffeinated beverages."},
    {"tip": "Stay active throughout the day: Incorporate physical activity into your daily routine, like taking the stairs or walking."},
    {"tip": "Manage stress: Find healthy ways to manage stress, such as yoga, hobbies, or talking to a therapist."},
    {"tip": "Eat more plant-based foods: Incorporate more fruits, vegetables, nuts, and seeds into your diet."},
    {"tip": "Avoid smoking: If you smoke, seek help to quit, and avoid exposure to secondhand smoke."},
    {"tip": "Get regular exercise: Mix cardio, strength training, and flexibility exercises for a well-rounded fitness routine."},
    {"tip": "Stay socially connected: Maintain strong social connections to support mental health."},
    {"tip": "Practice safe driving: Always wear your seatbelt and avoid distractions while driving."},
    {"tip": "Limit screen time: Take breaks from screens and practice eye exercises to reduce digital eye strain."},
    {"tip": "Brush and floss daily: Maintain good oral hygiene by brushing twice a day and flossing daily."},
    {"tip": "Eat mindfully: Pay attention to hunger cues and eat slowly to enjoy your food and avoid overeating."},
    {"tip": "Read labels: Check food labels for nutritional information and avoid high levels of sodium, sugars, and unhealthy fats."},
    {"tip": "Set realistic goals: Set achievable health and wellness goals to stay motivated and track progress."},
    {"tip": "Practice gratitude: Keep a gratitude journal or practice daily gratitude to improve overall well-being."},
    {"tip": "Take breaks: Rest and take breaks during long periods of work or study to avoid burnout."},
    {"tip": "Engage in cognitive activities: Keep your mind sharp with puzzles, reading, or learning new skills."},
    {"tip": "Get sunlight exposure: Spend some time outdoors to get natural sunlight and boost vitamin D levels."},
    {"tip": "Eat healthy fats: Include sources of healthy fats like avocados, nuts, and olive oil in your diet."},
    {"tip": "Manage your weight: Aim to maintain a healthy weight through balanced eating and regular physical activity."},
    {"tip": "Avoid overeating at night: Try not to eat large meals late at night to aid digestion and improve sleep quality."},
    {"tip": "Listen to your body: Pay attention to your body’s signals and rest when needed."},
    {"tip": "Be kind to yourself: Practice self-compassion and avoid negative self-talk."},
    {"tip": "Get a good night’s sleep: Establish a regular sleep routine and create a relaxing bedtime environment."},
    {"tip": "Stay organized: Keep your living space organized to reduce stress and improve efficiency."},
    {"tip": "Choose whole grains: Opt for whole grains over refined grains for better nutritional value."},
    {"tip": "Limit added salt: Reduce your intake of added salt to manage blood pressure levels."},
    {"tip": "Practice safe food handling: Follow proper food safety practices to avoid foodborne illnesses."},
    {"tip": "Stay informed: Keep up-to-date with health information and guidelines from trusted sources."},
    {"tip": "Seek support when needed: Don’t hesitate to ask for help or support for mental health or physical health concerns."},
    {"tip": "Celebrate small wins: Acknowledge and celebrate small achievements in your health journey."},
    {"tip": "Prioritize mental health: Take time for activities that promote mental and emotional well-being."},
    {"tip": "Engage in leisure activities: Make time for hobbies and activities that you enjoy and that relax you."},
    {"tip": "Be proactive about health: Take preventive measures and be proactive in managing your health."},
    {"tip": "Practice safe sex: Use protection and get regular health screenings to protect sexual health."},
    {"tip": "Stay positive: Maintain a positive outlook and focus on the things you can control for a healthier mindset."}
  ];

  void uploadData(BuildContext context) async {
    final CollectionReference healthTipsCollection = FirebaseFirestore.instance.collection('healthTips');

    try {
      for (var tip in healthTips) {
        await healthTipsCollection.add(tip);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Health tips uploaded successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading health tips: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Health Tips'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            uploadData(context);
          },
          child: Text('Upload Data'),
        ),
      ),
    );
  }
}
