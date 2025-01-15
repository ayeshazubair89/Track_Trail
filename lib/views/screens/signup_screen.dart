import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:track_trail2/views/screens/main_screen.dart';
import 'package:track_trail2/views/screens/signin_screen.dart';
import '../../reusable_widgets/reusable_widget.dart';
import '../../utils/color_utils.dart';
import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _passwordTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _userNameTextController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("FFFFFF"),
              hexStringToColor("FFFFFF"),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                // Logo Widget
              //  logoWidget("assets/images/onboarding_2.png"),
                Text(
                  'FitX',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4CAF50),
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  'Sign Up !',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  "Create your Account.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,

                    color: Colors.black54,
                    fontFamily: 'Poppins',
                  ),
                ),

                const SizedBox(height: 70),

                // Username Text Field
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  child: reusableTextField(
                    "Enter Username",
                    Icons.person_outline,
                    false,
                    _userNameTextController,
                  ),
                ),
                const SizedBox(height: 20),

                // Email Text Field
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  child: reusableTextField(
                    "Enter Email ID",
                    Icons.email_outlined,
                    false,
                    _emailTextController,
                  ),
                ),
                const SizedBox(height: 20),

                // Password Text Field
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  child: reusableTextField(
                    "Enter Password",
                    Icons.lock_outline,
                    true,
                    _passwordTextController,
                  ),
                ),
                const SizedBox(height: 20),

                // Sign Up Button
                isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                    });
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text)
                        .then((value) {
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainScreen(),
                        ),
                      );
                    }).onError((error, stackTrace) {
                      setState(() {
                        isLoading = false;
                      });
                      print("Error ${error.toString()}");
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor:Color(0xFF4CAF50), // Text color
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5.0,
                  ),
                  child: Text("Sign Up"),
                ),

                const SizedBox(height: 30),

                // Sign In Option
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?",
                        style: TextStyle(color: Colors.black54)),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        " Sign In",
                        style: TextStyle(
                            color: Color(0xFF4CAF50),
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
