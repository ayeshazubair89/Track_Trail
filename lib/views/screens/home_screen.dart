import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:track_trail2/views/screens/signin_screen.dart';
import 'package:track_trail2/views/screens/sleep_screen.dart';
import 'package:track_trail2/views/screens/water_intake.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fitness Tracker', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Container(
            width: double.infinity,
            height: 200,

            child: Stack(
              children: [

                Image.asset(
                  'assets/images/card1.png', // Your image path
                  fit: BoxFit.cover, // Ensures the image scales correctly
                  width: double.infinity,
                  height: double.infinity,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Healthy habits, happy life!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.black45,
                              blurRadius: 5,
                              offset: Offset(1, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                 /*   ElevatedButton(
                      onPressed: () {},
                      child: Text('Next'),
                    ),*/
                  ],
                ),
              ],
            ),
          ),

            SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildWaterIntakeTracker(),

                  Column(
                    children: [
                      _buildStreakTracker(),
                      SizedBox(height: 10),
                      _buildTrackerCardSleep(),

                    ],
                  ),
                ],
              ),

              SizedBox(height: 24),
              Text(
                'Workout Progress',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 8),
              _buildProgressChart(),
              SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 14.0, horizontal: 20.0),
                  ),
                  child: Text(
                    "Logout",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignInScreen()),
                      );
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStreakTracker() {
    return Container(
      width: 170, // Adjust the width as needed
      height: 120,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
      /*  borderRadius: BorderRadius.circular(10),*/
        color: Colors.green.shade50, // Light background color
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title row with icon
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            /*  Icon(
                Icons.local_fire_department, // Fire icon for streaks
                color: Colors.green,
                size: 30,
              ),*/
              SizedBox(width: 8),
              Text(
                'Streaks', // Title text
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          // Streak icons for the last 3 days
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildDayStreakIcon(true), // Streak maintained
              _buildDayStreakIcon(false), // Streak broken
              _buildDayStreakIcon(true),
              _buildDayStreakIcon(true), // Streak broken
              _buildDayStreakIcon(true),

            ],
          ),
         /* SizedBox(height: 5),*/
          // Summary text
          Text(
            'Stay Consistent!',
            style: TextStyle(
              color: Colors.green,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

// Helper function to create a streak icon for each day
  Widget _buildDayStreakIcon(bool isStreakMaintained) {
    return Icon(
      isStreakMaintained ? Icons.local_fire_department : Icons.close, // Fire or X icon
      color: isStreakMaintained ? Colors.green.shade500 : Colors.green,
      size: 28,
    );
  }


  Widget _buildTrackerCardSleep() {
    return InkWell(
        onTap: () {
      // Action to perform when tapped
      Navigator.push(context, MaterialPageRoute(builder: (context) => SleepInsightsScreen()));

    },
    splashColor: Colors.green.withOpacity(0.3), // Ripple effect color
    borderRadius: BorderRadius.circular(0.0), // Matches container's borderRadius
    child:

      Container(

      width: 170, // Adjust the width as needed
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        color: Colors.green.shade50, // Optional background color if you need one
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Sleep icon and text
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Icon(
                  Icons.bedtime, // Sleep icon
                  size: 30,
                  color: Colors.green,
                ),

              SizedBox(width: 8),
              Text(
                'Sleep', // Title text
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          // 8 hours / day text
          Text(
            '8 hours / day',
            style: TextStyle(
              color: Colors.green,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 15),
          // Rectangle-like label for "Normal"
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            decoration: BoxDecoration(
              color: Colors.green, // Background color for label
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Normal',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ));
  }


  Widget _buildWaterIntakeTracker() {
    return InkWell(
        onTap: () {
      // Action to perform when tapped
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WaterTrackerApp()));

    },
    splashColor: Colors.green.withOpacity(0.3), // Ripple effect color
    borderRadius: BorderRadius.circular(0.0), // Matches container's borderRadius
    child: Container(
      width: MediaQuery.of(context).size.width * 0.4,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(0.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child:

      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Water Intake',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '4 Liters',
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 8),
          // Custom progress bar
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 150,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              Container(
                height: 120, // Adjust based on water progress
                width: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green.shade200, Colors.green],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Column(
            children: [
              _buildWaterUpdate('5am - 8am', '600ml'),
              _buildWaterUpdate('8am - 11am', '500ml'),
              _buildWaterUpdate('11am - 2pm', '1000ml'),
              _buildWaterUpdate('2pm - 4pm', '700ml'),
              _buildWaterUpdate('4pm - Now', '900ml'),
            ],
          ),
        ],
      ),
    ));
  }




  Widget _buildWaterUpdate(String time, String volume) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            time,
            style: TextStyle(fontSize: 10, color: Colors.grey),
          ),
          Text(
            volume,
            style: TextStyle(fontSize: 10, color: Colors.green),
          ),
        ],
      ),
    );
  }


  /// Builds the progress chart using fl_chart
  Widget _buildProgressChart() {
    return Container(
      height: 200, // Increase for better display
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true, drawVerticalLine: true),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                  return Text(
                    weekdays[value.toInt()],
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 20,
                reservedSize: 32,
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: 6,
          minY: 0,
          maxY: 100,
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 20), // Monday progress
                FlSpot(1, 35), // Tuesday progress
                FlSpot(2, 50), // Wednesday progress
                FlSpot(3, 40), // Thursday progress
                FlSpot(4, 70), // Friday progress
                FlSpot(5, 90), // Saturday progress
                FlSpot(6, 75), // Sunday progress
              ],
              isCurved: true,
             /* color: [Colors.green],*/
              color: Colors.green,
              barWidth: 4,
              belowBarData: BarAreaData(
                show: true,
                color: Colors.green.withOpacity(0.3),
              ),
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, bar, index) => FlDotCirclePainter(
                  radius: 4,
                  color: Colors.white,
                  strokeWidth: 2,
                  strokeColor: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.green,
    ),
    home: HomeScreen(),
  ));
}




