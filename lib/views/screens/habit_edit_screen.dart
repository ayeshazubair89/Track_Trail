import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/habit_model.dart';

class HabitEditScreen extends StatefulWidget {
  final Habit? habit;

  HabitEditScreen({this.habit});

  @override
  _HabitEditScreenState createState() => _HabitEditScreenState();
}

class _HabitEditScreenState extends State<HabitEditScreen> {
  final _titleController = TextEditingController();
  String _repeatFrequency = 'Daily'; // Default value

  @override
  void initState() {
    super.initState();
    if (widget.habit != null) {
      _titleController.text = widget.habit!.title;
      _repeatFrequency = widget.habit!.repeatFrequency;
    }
  }

  void _saveHabit() async {
    final title = _titleController.text;
    final repeatFrequency = _repeatFrequency;

    // Create or update a habit
    if (widget.habit != null) {
      // Update existing habit
      FirebaseFirestore.instance.collection('habits').doc(widget.habit!.id).update({
        'title': title,
        'repeatFrequency': repeatFrequency,
      });
    } else {
      // Add new habit
      final newHabit = Habit(
        id: '', // Firestore will auto-generate this
        title: title,
        repeatFrequency: repeatFrequency,
        completionDates: {}, // Start with an empty map
      );

      await FirebaseFirestore.instance.collection('habits').add(newHabit.toMap());
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.habit != null ? 'Edit Habit' : 'New Habit'),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveHabit,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Habit Title'),
            ),
            DropdownButton<String>(
              value: _repeatFrequency,
              onChanged: (String? newValue) {
                setState(() {
                  _repeatFrequency = newValue!;
                });
              },
              items: <String>['Daily', 'Weekly', 'Monthly'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            // Additional form fields can go here
          ],
        ),
      ),
    );
  }
}
class HabitCalendar extends StatelessWidget {
  final Habit habit;

  HabitCalendar({required this.habit});

  // This method toggles the completion status of a habit for a given date
  void _toggleCompletion(String date) async {
    final updatedDates = Map<String, bool>.from(habit.completionDates);
    updatedDates[date] = !(updatedDates[date] ?? false);

    await FirebaseFirestore.instance.collection('habits').doc(habit.id).update({
      'completionDates': updatedDates,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: habit.completionDates.keys.map((date) {
        bool completed = habit.completionDates[date] ?? false;
        return GestureDetector(
          onTap: () => _toggleCompletion(date),
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: completed ? Colors.green : Colors.red,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              date.split('-').last, // Display only the day part of the date
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      }).toList(),
    );
  }
}
