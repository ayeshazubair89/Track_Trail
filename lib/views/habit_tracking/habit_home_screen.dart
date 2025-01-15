import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'add_habit_screen.dart';


class HabitTrackingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HabitListScreen(),
    );
  }
}

class HabitListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Habit Tracker",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF4CAF50),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today, color: Colors.white),
            onPressed: () {
              // Navigate to a calendar view screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HabitCalendarScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Calendar section (Horizontal date view)
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            color: const Color(0xFF4CAF50),

            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(31, (index) {
                  DateTime date = DateTime(2024, 12, index + 1); // Generate dates for December 2024
                  String formattedDate = '${date.day.toString().padLeft(2, '0')} Dec';

                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        formattedDate,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          // Habit List Section
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('habits').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(color: const Color(0xFF4CAF50)));
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.red)));
                }
                if (!snapshot.hasData || snapshot.data == null || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No data available', style: TextStyle(color: const Color(0xFF4CAF50))));
                }

                var habits = snapshot.data!.docs;

                return ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: habits.length,
                  itemBuilder: (context, index) {
                    var habit = habits[index];
                    var habitData = habit.data() as Map<String, dynamic>?;

                    String title = habitData != null && habitData.containsKey('title')
                        ? habitData['title']
                        : 'Untitled Habit';

                    int currentValue = habitData != null &&
                        habitData.containsKey('progress') &&
                        habitData['progress'] is Map<String, dynamic> &&
                        habitData['progress']!.containsKey('currentValue')
                        ? habitData['progress']!['currentValue']
                        : 0;

                    int targetValue = habitData != null &&
                        habitData.containsKey('progress') &&
                        habitData['progress'] is Map<String, dynamic> &&
                        habitData['progress']!.containsKey('targetValue')
                        ? habitData['progress']!['targetValue']
                        : 0;

                    String units = habitData != null &&
                        habitData.containsKey('progress') &&
                        habitData['progress'] is Map<String, dynamic> &&
                        habitData['progress']!.containsKey('units')
                        ? habitData['progress']!['units']
                        : '';

                    return Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 4,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(
                          title,
                          style: TextStyle(
                            color: const Color(0xFF4CAF50),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Progress: $currentValue / $targetValue $units',
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                        onTap: () {
                          // Navigate to a detail screen if needed
                        },
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: const Color(0xFFB0C7E1)),
                              onPressed: () {
                                // Navigate to edit screen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddHabitScreen(habitId: habit.id),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.check_circle, color: Colors.green),
                              onPressed: () {
                                // Mark habit as complete
                                FirebaseFirestore.instance
                                    .collection('habits')
                                    .doc(habit.id)
                                    .update({'completed': true});
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                // Delete habit
                                FirebaseFirestore.instance.collection('habits').doc(habit.id).delete();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddHabitDialog(context);
        },
        backgroundColor: const Color(0xFF4CAF50),
        child: Icon(Icons.add, color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  void _showAddHabitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddHabitDialog();
      },
    );
  }
}

// Placeholder for the habit editing screen
class AddHabitScreen extends StatelessWidget {
  final String? habitId;

  AddHabitScreen({this.habitId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(habitId == null ? 'Add Habit' : 'Edit Habit'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: Center(
        child: Text('Edit/Add Habit Form Goes Here'),
      ),
    );
  }
}

// Placeholder for the calendar tracking screen
class HabitCalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Habit Calendar'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
      body: Center(
        child: Text('Calendar View Goes Here'),
      ),
    );
  }
}

