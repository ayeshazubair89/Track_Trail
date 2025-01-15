import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:track_trail2/views/screens/signin_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              hexStringToColor("DFF0E3"),
              hexStringToColor("F2FBF5"),
            ],
          ),
        ),
        child: IntroductionScreen(
          pages: [
            // Screen 1
            PageViewModel(
              title: '',
              bodyWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  Image.asset(
                    'assets/images/onboarding_1.png',
                    height: 280,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 40),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Welcome to FitX',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Color(0xFF4CAF50),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Start your self-improvement journey with FitX. Discover powerful features to track and enhance your habits.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                            fontFamily: 'Poppins',
                          ),
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
                  SizedBox(height: 40),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Grow With Ease',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Color(0xFF4CAF50),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Connect with a community of like-minded individuals and share experiences to fuel your personal growth.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Image.asset(
                    'assets/images/onboarding_2.png',
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            // Screen 3
            PageViewModel(
              title: '',
              bodyWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  Image.asset(
                    'assets/images/onboarding_3.png',
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 40),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Be Your Best',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            color: Color(0xFF4CAF50),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Get personalized recommendations and build positive habits to become the best version of yourself.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          onDone: () async {
            // Mark onboarding as complete
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setBool('onboardingComplete', true);

            // Navigate to the sign-in screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignInScreen()),
            );
          },
          showSkipButton: true,
          skip: const Text('Skip', style: TextStyle(fontSize: 16, color: Color(0xFF4CAF50))),
          next: const Icon(Icons.arrow_forward, color: Color(0xFF4CAF50)),
          done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF4CAF50))),
          dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(22.0, 10.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            activeColor: Color(0xFF4CAF50),
            color: Colors.blueGrey,
          ),
        ),
      ),
    );
  }

  Color hexStringToColor(String hex) {
    hex = hex.replaceAll("#", "");
    if (hex.length == 6) {
      hex = "FF" + hex;
    }
    if (hex.length == 8) {
      return Color(int.parse("0x$hex"));
    }
    return Colors.black; // Default color if invalid hex string
  }
}
