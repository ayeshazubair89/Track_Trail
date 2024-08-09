import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/habit_model.dart';
import 'habit_edit_screen.dart';

class HabitTrackingScreen extends StatefulWidget {
  @override
  _HabitTrackingScreenState createState() => _HabitTrackingScreenState();
}

class _HabitTrackingScreenState extends State<HabitTrackingScreen> {
  final CollectionReference habitsRef =
  FirebaseFirestore.instance.collection('habits');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Habit Tracker'),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HabitEditScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: habitsRef.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          List<Habit> habits = snapshot.data!.docs
              .map((doc) => Habit.fromMap(doc.id, doc.data() as Map<String, dynamic>))
              .toList();

          return ListView.builder(
            itemCount: habits.length,
            itemBuilder: (context, index) {
              Habit habit = habits[index];
              return HabitCard(habit: habit);
            },
          );
        },
      ),
    );
  }
}

class HabitCard extends StatelessWidget {
  final Habit habit;

  HabitCard({required this.habit});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              habit.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text('Repeat: ${habit.repeatFrequency}'),
            SizedBox(height: 10),
            HabitCalendar(habit: habit),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HabitEditScreen(habit: habit),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HabitCalendar extends StatelessWidget {
  final Habit habit;

  HabitCalendar({required this.habit});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: habit.completionDates.keys.map((date) {
        bool completed = habit.completionDates[date] ?? false;
        return GestureDetector(
          onTap: () {
            // Handle toggling habit completion here
          },
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
