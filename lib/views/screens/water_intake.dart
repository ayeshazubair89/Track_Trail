import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:intl/intl.dart';

import 'home_screen.dart';
import 'main_screen.dart';

class WaterTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: UserInputForm(),
    );
  }
}

class UserInputForm extends StatefulWidget {
  @override
  _UserInputFormState createState() => _UserInputFormState();
}

class _UserInputFormState extends State<UserInputForm> {
  final _formKey = GlobalKey<FormState>();
  String? _gender;
  String? _ageRange;
  double? _weight;
  String? _activityLevel;
  String? _environment;

  String _recommendedWaterIntake = "";
  String _additionalTips = "";

  // For Daily Water Intake Tracker
  int _dailyGoal = 8; // Default: 8 glasses
  int _consumedGlasses = 0; // Glasses consumed by the user
  String _intakeMode = "Default"; // Intake mode: Default, Auto, or Custom

  // History list to store daily intake records
  List<Map<String, dynamic>> _history = [];

  void _calculateWaterIntake() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      double baseWaterIntake = 8.0;

      // Gender-based calculation
      if (_gender == 'Male') {
        baseWaterIntake += 2; // Males need more water
      } else if (_gender == 'Female') {
        baseWaterIntake -= 1; // Females may need slightly less
      }

      if (_weight != null) {
        baseWaterIntake += _weight! * 0.03;
      }

      if (_activityLevel == 'Moderate') {
        baseWaterIntake += 2;
      } else if (_activityLevel == 'Active') {
        baseWaterIntake += 4;
      }

      if (_environment == 'Hot climate') {
        baseWaterIntake += 2;
      } else if (_environment == 'Cold climate') {
        baseWaterIntake -= 1;
      }

      setState(() {
        _recommendedWaterIntake =
        "Aapko rozana ${baseWaterIntake.toStringAsFixed(1)} glasses pani peena chahiye.";
        _additionalTips = "Tips:\n"
            "1. Active logon ko zyadah pani peene ki zarurat hoti hai.\n"
            "2. Garm mausam mein dehydration se bachein aur pani kaafi peeyin.\n"
            "3. Din bhar chhoti matra mein pani peena acha hota hai.\n"
            "4. Exercise karne ke baad pani zarur peeyin.";

        if (_intakeMode == "Auto") {
          _dailyGoal = baseWaterIntake.ceil();
        }
      });
    }
  }

  void _addGlass() {
    if (_consumedGlasses < _dailyGoal) {
      setState(() {
        _consumedGlasses++;
      });
    }
  }

  void _resetTracker() {
    setState(() {
      _consumedGlasses = 0;
    });
  }

  void _saveHistory() {
    String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _history.add({
      'date': date,
      'consumed': _consumedGlasses,
    });
  }

  @override
  Widget build(BuildContext context) {
    double progress = _consumedGlasses / _dailyGoal;

    return Scaffold(
      appBar: AppBar(
        title: Text('Water Tracker'),
        backgroundColor: Colors.green[700],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
            /*Navigator.pop(context);*/ // Go back to the previous screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Existing UI for gender, age, weight, activity, and environment inputs
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Gender',
                          border: OutlineInputBorder(),
                        ),
                        items: ['Male', 'Female', 'Other']
                            .map((gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                        validator: (value) =>
                        value == null ? 'Please select your gender' : null,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Age Range',
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          'Below 18',
                          '18–30',
                          '30–50',
                          '50+',
                        ]
                            .map((age) => DropdownMenuItem(
                          value: age,
                          child: Text(age),
                        ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _ageRange = value;
                          });
                        },
                        validator: (value) =>
                        value == null ? 'Please select your age range' : null,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Weight (kg)',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          _weight = double.tryParse(value ?? '0');
                        },
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter your weight'
                            : null,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Activity Level',
                          border: OutlineInputBorder(),
                        ),
                        items: ['Sedentary', 'Moderate', 'Active']
                            .map((level) => DropdownMenuItem(
                          value: level,
                          child: Text(level),
                        ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _activityLevel = value;
                          });
                        },
                        validator: (value) => value == null
                            ? 'Please select your activity level'
                            : null,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Environment',
                          border: OutlineInputBorder(),
                        ),
                        items: ['Hot climate', 'Normal', 'Cold climate']
                            .map((env) => DropdownMenuItem(
                          value: env,
                          child: Text(env),
                        ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _environment = value;
                          });
                        },
                        validator: (value) => value == null
                            ? 'Please select your environment'
                            : null,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _calculateWaterIntake,
                  child: Text('Calculate Water Intake'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                  ),
                ),
                SizedBox(height: 20),
                if (_recommendedWaterIntake.isNotEmpty)
                  Text(
                    _recommendedWaterIntake,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                if (_additionalTips.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      _additionalTips,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                SizedBox(height: 20),

                // New UI: Daily Water Intake Tracker
                Divider(),
                Text(
                  "Daily Water Intake Tracker",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
                ),
                SizedBox(height: 10),
                CircularPercentIndicator(
                  radius: 100.0,
                  lineWidth: 12.0,
                  percent: progress > 1 ? 1 : progress,
                  center: Text(
                    "${(progress * 100).toStringAsFixed(1)}%",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                  progressColor: Colors.green[700],
                ),
                SizedBox(height: 10),
                Text(
                  "Consumed: $_consumedGlasses / $_dailyGoal glasses",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _addGlass,
                        child: Text('Add Glass'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _resetTracker,
                        child: Text('Reset'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[700],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // History Section
                Text(
                  "Water Intake History",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _history.length,
                  itemBuilder: (context, index) {
                    final historyEntry = _history[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        title: Text(
                          "Date: ${historyEntry['date']}",
                          style: TextStyle(fontSize: 16),
                        ),
                        subtitle: Text(
                          "Consumed: ${historyEntry['consumed']} glasses",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveHistory,
        tooltip: 'Save History',
        child: Icon(Icons.save),
      ),
    );
  }
}


