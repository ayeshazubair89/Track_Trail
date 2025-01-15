import 'package:flutter/material.dart';

class SleepInsightsScreen extends StatefulWidget {
  @override
  _SleepInsightsScreenState createState() => _SleepInsightsScreenState();
}

class _SleepInsightsScreenState extends State<SleepInsightsScreen> {
  TimeOfDay bedtime = TimeOfDay(hour: 22, minute: 0);
  TimeOfDay wakeTime = TimeOfDay(hour: 6, minute: 0);
  bool exercisedToday = false;
  String caffeineIntake = "None";

  String sleepQuality = "Unknown";
  List<String> insights = [];

  void calculateSleepInsights() {
    // Calculate sleep duration
    final duration = wakeTime.hour + wakeTime.minute / 60.0 -
        (bedtime.hour + bedtime.minute / 60.0);
    final sleepDuration = duration < 0 ? 24 + duration : duration;

    // Determine sleep quality
    if (sleepDuration >= 7 && sleepDuration <= 9 && !exercisedToday && caffeineIntake == "None") {
      sleepQuality = "Good";
    } else if (sleepDuration >= 6) {
      sleepQuality = "Normal";
    } else {
      sleepQuality = "Poor";
    }

    // Generate personalized insights
    insights = [];
    if (!exercisedToday) insights.add("Your sleep improves when you exercise during the day.");
    if (caffeineIntake != "None") insights.add("Avoid caffeine intake after 6 PM for better sleep.");
    if (sleepDuration < 7) insights.add("Increasing your sleep duration improves sleep quality.");

    setState(() {});
  }

  Future<void> pickTime({required bool isBedtime}) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isBedtime ? bedtime : wakeTime,
    );
    if (picked != null) {
      setState(() {
        if (isBedtime) {
          bedtime = picked;
        } else {
          wakeTime = picked;
        }
      });
      calculateSleepInsights();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sleep Insights"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text("Bedtime: ${bedtime.format(context)}"),
              trailing: ElevatedButton(
                onPressed: () => pickTime(isBedtime: true),
                child: Text("Set"),
              ),
            ),
            ListTile(
              title: Text("Wake Time: ${wakeTime.format(context)}"),
              trailing: ElevatedButton(
                onPressed: () => pickTime(isBedtime: false),
                child: Text("Set"),
              ),
            ),
            ListTile(
              title: Text("Exercised Today"),
              trailing: Switch(
                value: exercisedToday,
                onChanged: (value) {
                  setState(() {
                    exercisedToday = value;
                  });
                  calculateSleepInsights();
                },
              ),
            ),
            ListTile(
              title: Text("Caffeine Intake"),
              trailing: DropdownButton<String>(
                value: caffeineIntake,
                items: ["None", "Low", "Moderate", "High"]
                    .map((e) => DropdownMenuItem(child: Text(e), value: e))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    caffeineIntake = value!;
                  });
                  calculateSleepInsights();
                },
              ),
            ),
            SizedBox(height: 20),
            Text("Sleep Quality: $sleepQuality", style: TextStyle(fontSize: 18)),
            Divider(),
            Text("Insights:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...insights.map((e) => Text("- $e")),
          ],
        ),
      ),
    );
  }
}
