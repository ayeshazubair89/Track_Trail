// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:track_trail2/views/screens/onboarding_screen.dart';
// import 'package:track_trail2/views/screens/signin_screen.dart';
//
// import 'firebase_options.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   bool onboardingComplete = prefs.getBool('onboardingComplete') ?? false;
//
//   runApp(MyApp(onboardingComplete: onboardingComplete));
// }
//
// class MyApp extends StatelessWidget {
//   final bool onboardingComplete;
//
//   const MyApp({super.key, required this.onboardingComplete});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Track Trail',
//       theme: ThemeData(
//         primaryColor: const Color(0xFFDFF0E3), // Light Green
//         fontFamily: 'Poppins',
//         colorScheme: ColorScheme(
//           primary: const Color(0xFF4CAF50),       // Green
//           primaryContainer: const Color(0xFFDFF0E3), // Light Green
//           secondary: const Color(0xFF4CAF50),    // Green
//           secondaryContainer: const Color(0xFFDFF0E3), // Light Green
//           surface: Colors.white,
//           background: Colors.white,
//           error: Colors.red,
//           onPrimary: Colors.white,
//           onSecondary: Colors.white,
//           onSurface: Colors.black,
//           onBackground: Colors.black,
//           onError: Colors.white,
//           brightness: Brightness.light,
//         ),
//         scaffoldBackgroundColor: Colors.white,
//         useMaterial3: true,
//       ),
//       home: onboardingComplete ? SignInScreen() : OnboardingScreen(),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:track_trail2/views/screens/onboarding_screen.dart';
import 'package:track_trail2/views/screens/signin_screen.dart';
import 'package:track_trail2/views/screens/sleep_screen.dart';
import 'package:track_trail2/views/screens/water_intake.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool onboardingComplete = prefs.getBool('onboardingComplete') ?? false;

  runApp(MyApp(onboardingComplete: onboardingComplete));
}

class MyApp extends StatelessWidget {
  final bool onboardingComplete;

  const MyApp({super.key, required this.onboardingComplete});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Track Trail',
      debugShowCheckedModeBanner: false, // This disables the debug banner
      theme: ThemeData(
        primaryColor: const Color(0xFFDFF0E3), // Light Green
        fontFamily: 'Poppins',
        colorScheme: ColorScheme(
          primary: const Color(0xFF4CAF50),       // Green
          primaryContainer: const Color(0xFFDFF0E3), // Light Green
          secondary: const Color(0xFF4CAF50),    // Green
          secondaryContainer: const Color(0xFFDFF0E3), // Light Green
          surface: Colors.white,
          background: Colors.white,
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: Colors.white,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: onboardingComplete ?SignInScreen() : OnboardingScreen(),
      /* WaterTrackerApp(): WaterTrackerApp(),*/
      /*SleepDashboardScreen():SleepDashboardScreen(),*/

    );
  }
}

