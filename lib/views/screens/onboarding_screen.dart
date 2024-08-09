import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:track_trail2/views/screens/signin_screen.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          // Screen 1
          PageViewModel(
            title: '',
            bodyWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 80),
                Image.asset('assets/images/onboarding_1.png'), // Replace with your actual image path
                SizedBox(height: 80),
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFdfeef6), // Use your theme color
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Welcome to TRack TRail',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5A718C), // Use your theme color
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Start your self-improvement journey with TRack TRail.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Screen 2
          PageViewModel(
            title: '',
            bodyWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100),
                Container(
                  padding: EdgeInsets.all(16.0),
                  margin: EdgeInsets.only(bottom: 30),
                  decoration: BoxDecoration(
                    color: Color(0xFFEEDFEF), // Use your theme color
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Grow With Ease',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFDDAABB), // Use your theme color
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Connect with like-minded individuals in our Community Chat, sharing experiences and advice to fuel your growth.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Image.asset('assets/images/onboarding_2.png'), // Replace with your actual image path
              ],
            ),
          ),
          // Screen 3
          PageViewModel(
            title: '',
            bodyWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 80),
                Image.asset('assets/images/onboarding_3.png'), // Replace with your actual image path
                SizedBox(height: 80),
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFFDF4DD), // Use your theme color
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Be Your Best',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFCBB891), // Use your theme color
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Discover personalized recommendations, curated to help you build positive habits and become a better version of yourself.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
        onDone: () {
          // Navigate to your app's main screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SignInScreen()),
          );
        },
        showSkipButton: true,
        skip: const Text('Skip'),
        next: const Icon(Icons.arrow_forward),
        done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
        dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          activeColor:   Color(0xFFdfeef6),
        ),
      ),
    );
  }
}


