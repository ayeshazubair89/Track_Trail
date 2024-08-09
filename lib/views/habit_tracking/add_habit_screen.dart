import 'package:flutter/material.dart';
import 'eveluation_method_screen.dart';

class AddHabitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Habit'),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: [
          habitCategoryButton(context, 'Quit a Bad Habit'),
          habitCategoryButton(context, 'Art'),
          habitCategoryButton(context, 'Meditation'),
          // Add more categories here
        ],
      ),
    );
  }

  Widget habitCategoryButton(BuildContext context, String category) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EvaluationMethodsScreen(category: category),
            ),
          );
        },
        child: Center(
          child: Text(category),
        ),
      ),
    );
  }
}
