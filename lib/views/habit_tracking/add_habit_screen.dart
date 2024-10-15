import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddHabitDialog extends StatefulWidget {
  @override
  _AddHabitDialogState createState() => _AddHabitDialogState();
}

class _AddHabitDialogState extends State<AddHabitDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _goalController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _targetValueController = TextEditingController(); // Target value input
  String _evaluationMethod = "yes_no";  // Default evaluation method
  String _frequency = "daily";  // Default frequency
  String _units = "times";  // Default units

  void _saveHabit() {
    FirebaseFirestore.instance.collection('habits').add({
      'title': _titleController.text,
      'goal': _goalController.text,
      'description': _descriptionController.text,
      'evaluationMethod': _evaluationMethod,
      'frequency': _frequency,
      'progress': {
        'currentValue': 0,
        'targetValue': int.tryParse(_targetValueController.text) ?? 0,
        'units': _units,
        'history': []
      },
    }).then((value) {
      Navigator.of(context).pop();
    }).catchError((error) {
      print('Failed to add habit: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: const Color(0xFFF2FBF5),
      title: Center(
        child: Text(
          "Define Your Habit",
          style: TextStyle(
            color: const Color(0xFF4CAF50),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField("Habit Title", _titleController),
            SizedBox(height: 10),
            _buildTextField("Goal", _goalController),
            SizedBox(height: 10),
            _buildTextField("Description", _descriptionController),
            SizedBox(height: 10),
            _buildTextField("Target Value", _targetValueController, TextInputType.number),
            SizedBox(height: 10),
            _buildDropdown("Units", _units, ['times', 'minutes', 'hours'], (newValue) {
              setState(() {
                _units = newValue!;
              });
            }),
            SizedBox(height: 10),
            _buildDropdown("Evaluation Method", _evaluationMethod, ['yes_no', 'checklist', 'numeric', 'timer'], (newValue) {
              setState(() {
                _evaluationMethod = newValue!;
              });
            }),
            SizedBox(height: 10),
            _buildDropdown("Frequency", _frequency, ['daily', 'weekly', 'monthly'], (newValue) {
              setState(() {
                _frequency = newValue!;
              });
            }),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "Cancel",
            style: TextStyle(
              color: const Color(0xFF4CAF50),
              fontSize: 16,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _saveHabit,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4CAF50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            "Save",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, [TextInputType keyboardType = TextInputType.text]) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: const Color(0xFF4CAF50)),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: const Color(0xFF4CAF50), width: 2),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, String value, List<String> items, void Function(String?)? onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: const Color(0xFF4CAF50)),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: const Color(0xFF4CAF50), width: 2),
        ),
      ),
    );
  }
}
