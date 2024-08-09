import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HabitDetailsScreen extends StatefulWidget {
  final String category;
  final String evaluationMethod;

  HabitDetailsScreen({required this.category, required this.evaluationMethod});

  @override
  _HabitDetailsScreenState createState() => _HabitDetailsScreenState();
}

class _HabitDetailsScreenState extends State<HabitDetailsScreen> {
  final TextEditingController _titleController = TextEditingController();
  String _repeatFrequency = 'Daily';
  Map<String, bool> _completionDates = {};

  void _saveHabit() async {
    final title = _titleController.text;
    final repeatFrequency = _repeatFrequency;

    // Example completion dates, adjust this as needed
    final completionDates = _completionDates;

    await saveHabit(title, repeatFrequency, completionDates);

    Navigator.pop(context); // Navigate back to the previous screen after saving
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Habit Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Habit Title'),
            ),
            SizedBox(height: 20),
            Text('Repeat Frequency'),
            DropdownButton<String>(
              value: _repeatFrequency,
              onChanged: (String? newValue) {
                setState(() {
                  _repeatFrequency = newValue!;
                });
              },
              items: <String>['Daily', 'Weekly', 'Monthly']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            // Here you can add more widgets for setting up completionDates or other details
            ElevatedButton(
              onPressed: _saveHabit,
              child: Text('Save Habit'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveHabit(String title, String repeatFrequency, Map<String, bool> completionDates) async {
    final CollectionReference habitsRef = FirebaseFirestore.instance.collection('habits');

    final habitData = {
      'title': title,
      'repeatFrequency': repeatFrequency,
      'completionDates': completionDates,
    };

    DocumentReference docRef = await habitsRef.add(habitData);

    print("Habit added with ID: ${docRef.id}");
  }
}
