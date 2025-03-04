import 'package:flutter/material.dart';

import 'package:track_trail2/views/screens/todo_screen.dart';
import '../habit_tracking/habit_home_screen.dart';
import 'home_screen.dart';
import 'notification_screen.dart';

import 'profile_screen.dart';


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    HabitTrackingApp(),

 /*   NotificationScreen(),*/
    YouTubeHealthScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Color(0xFF4CAF50),),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.art_track, color:Color(0xFF4CAF50),),
            label: 'Track ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.recommend_rounded, color: Color(0xFF4CAF50),),
            label: 'Recomendation',
          ),
          /*BottomNavigationBarItem(
            icon: Icon(Icons.notifications, color: Color(0xFF4CAF50),),
            label: 'Notifications',
          ),*/
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Color(0xFF4CAF50),),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
