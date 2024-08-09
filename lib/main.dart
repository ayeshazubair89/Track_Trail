import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:track_trail2/views/habit_tracking/habit_home_screen.dart';
import 'package:track_trail2/views/screens/onboarding_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TRack TRail',
      theme: ThemeData(
        primaryColor: const Color(0xFFDFEEF6), // Light blue
        colorScheme: ColorScheme(
          primary: const Color(0xFFB0C7E1),       // Light blue
          primaryContainer: const Color(0xFFDFEEF6), // Light blue
          secondary: const Color(0xFFB0C7E1),    // Light blue
          secondaryContainer: const Color(0xFFDFEEF6), // Light blue
          surface: Colors.white,
          background: Colors.white,               // Set this to white
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: Colors.white,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.white, // Ensure the scaffold background is white
        useMaterial3: true,
      ),
      home: HabitHomeScreen (),
    );
  }
}
