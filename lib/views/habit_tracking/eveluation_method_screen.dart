import 'package:flutter/material.dart';
import 'package:track_trail2/views/habit_tracking/habit_detail_sreen.dart';


class EvaluationMethodsScreen extends StatelessWidget {
  final String category;

  EvaluationMethodsScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Evaluate Progress'),
      ),
      body: Column(
        children: [
          Text('How do you want to evaluate your progress?'),
          evaluationButton(context, 'Yes/No'),
          evaluationButton(context, 'Numerical Values'),
          evaluationButton(context, 'Timer'),
          evaluationButton(context, 'Checklist'),
        ],
      ),
    );
  }

  Widget evaluationButton(BuildContext context, String method) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HabitDetailsScreen(category: category, evaluationMethod: method),
          ),
        );
      },
      child: Text(method),
    );
  }
}

