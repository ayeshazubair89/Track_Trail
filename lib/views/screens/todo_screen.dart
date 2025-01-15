import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YouTube Recommendation',
      theme: ThemeData(
        primaryColor: Color(0xFF4CAF50),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF4CAF50),
          elevation: 0,
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      home: YouTubeHealthScreen(),
    );
  }
}

class YouTubeHealthScreen extends StatefulWidget {
  @override
  _YouTubeHealthScreenState createState() => _YouTubeHealthScreenState();
}

class _YouTubeHealthScreenState extends State<YouTubeHealthScreen> {
  final String apiKey = 'AIzaSyCJK8V6m5a1T-Z-BxkzyaZGLqMAAzYVnFo'; // 🔹 Replace with your API Key
  String selectedCategory = 'Health'; // Default Category
  List videos = [];

  @override
  void initState() {
    super.initState();
    fetchVideos(selectedCategory);
  }

  Future<void> fetchVideos(String query) async {
    final String url =
        'https://www.googleapis.com/youtube/v3/search?part=snippet&q=$query&key=$apiKey&type=video&maxResults=10';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        videos = json.decode(response.body)['items'];
      });
    } else {
      throw Exception('Failed to load videos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('YouTube Recommendation'), centerTitle: true),
      body: Column(
        children: [
          // Styled Dropdown
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedCategory,
                  icon: Icon(Icons.arrow_drop_down, color: Color(0xFF4CAF50)),
                  dropdownColor: Colors.white, // Background color of dropdown items
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                  items: ['Health', 'Yoga', 'Workout', 'Dieting', 'Meditation', 'Water Intake']
                      .map((String category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          category,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value!;
                      fetchVideos(selectedCategory);
                    });
                  },
                ),
              ),
            ),
          ),
          // Video List
          Expanded(
            child: videos.isEmpty
                ? Center(child: CircularProgressIndicator(color: Color(0xFF4CAF50)))
                : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 12),
              itemCount: videos.length,
              itemBuilder: (context, index) {
                var video = videos[index];
                var videoId = video['id']['videoId'];
                var title = video['snippet']['title'];
                var thumbnail = video['snippet']['thumbnails']['medium']['url'];

                return Card(
                  elevation: 4,
                  margin: EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: InkWell(
                    onTap: () {
                      launchUrl(Uri.parse('https://www.youtube.com/watch?v=$videoId'));
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
                          child: Image.network(thumbnail, width: 120, height: 80, fit: BoxFit.cover),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Icon(Icons.play_circle_fill, color: Color(0xFF4CAF50), size: 32),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

