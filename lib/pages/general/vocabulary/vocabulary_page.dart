import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:english_hakaton/route/route.gr.dart';
import 'package:english_hakaton/theme/main_theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VocabularyPage extends StatefulWidget {
  const VocabularyPage({Key? key}) : super(key: key);

  @override
  State<VocabularyPage> createState() => _VocabularyPageState();
}

class _VocabularyPageState extends State<VocabularyPage> {
  static const String baseIP = '91.199.45.37:7050';
// 91.199.45.37:7050
  final String userName = 'VOCABULARY';
  final String userCourse = 'USER';
  final int wordsLearned = 210;
  final int totalWords = 270;
  final int wordsToStudy = 130;
  final int wordsToRepeat = 73;
  int pageCount = 0;
  static int needPage = 1;
  Map<String, bool> buttonPressed = {};
  String? activeButton = "1";

  @override
  void initState() {
    super.initState();
    // Initialize the button states (assuming you know the button labels beforehand)
    // This step might be dynamic based on actual data in a real application
    fetchCountForUser(1);

    for (int i = 1; i <= buttonPressed.length-1; i++) {
      buttonPressed['$i'] = false;
    }
  }

  Future<Map<String, dynamic>> fetchData(int page, int pageSize) async {
    final response = await http.get(Uri.http(baseIP, '/page-for-user', {
      'user-id': '1',
      'page': page.toString(),
      'page-size': pageSize.toString(),
    }));

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> fetchCountForUser(int userId) async {
    final response = await http.get(Uri.http(baseIP, '/count-for-user', {
      'user-id': userId.toString(),
    }));

    try {
      if (response.statusCode == 200) {
        pageCount = int.parse(response.body);
        print('${pageCount}' + " pages");
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userName),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchData(needPage, 10),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return _buildUserInfoSection();
          }

          Map<String, dynamic> wordsMapResponse = snapshot.data!;

          return ListView(
            padding: EdgeInsets.all(5.0),
            children: [
              // User Info and Progress
              _buildUserInfoSection(),
              // Lessons Progress List
              ...wordsMapResponse.entries.map((entry) {
                return _buildLessonProgress(entry.key, entry.value);
              }).toList(),
              _buildPageNavigation(context),
            ],
          );
        },
      ),
    );
  }
Widget _buildUserInfoSection() {
  return Container(
    decoration: BoxDecoration(
      color: mainColor,
      borderRadius: BorderRadius.circular(10),
    ),
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          userCourse,
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(height: 8),
        Text(
          'Learned $wordsLearned/$totalWords words' ,
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: wordsLearned / totalWords,
            backgroundColor: Colors.white,
            minHeight: 10,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade300),
          ),
        ),
        SizedBox(height: 16),
        // Study and Add Words buttons...
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: mainColor,
          ),
          padding: const EdgeInsets.all(15.0),
          child: Column(children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('STUDY'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: backgroundColor),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.router.push(WordSetRoute());
                  },
                  child: Text('ADD WORDS'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: backgroundColor),
                ),
              ],
            )
          ]),
        ),
        // ...
      ],
    ),
  );
}

Card _buildLessonProgress(String title, dynamic value) {
  return Card(
    color: mainColor, // Set your desired background color here
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: ListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      subtitle: LinearProgressIndicator(
        value: (value ?? 0) / 5, // Use the actual value or a placeholder
        backgroundColor: Colors.grey[300],
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
      ),
      trailing: Text(
        '${value ?? 0}/5',
        style: TextStyle(color: Colors.white),
      ), // Use the actual value or a placeholder
    ),
  );
}

Widget _buildPageNavigation(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    height: 50, // Fixed height for the container
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Enable horizontal scrolling
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate((pageCount / 15).ceil(), (index) {
          // Dynamically generate buttons
          String buttonLabel = '${index + 1}';
          return Row(
            children: [
              _navigationButton(context, buttonLabel),
              SizedBox(width: 10), // Space between buttons
            ],
          );
        }),
      ),
    ),
  );
}
Widget _navigationButton(BuildContext context, String page) {
  bool isActive =
      activeButton == page; // Check if this button is the active one
  return TextButton(
    onPressed: () {
      setState(() {
        if (isActive) {
          activeButton = null; // Deselect if already active
        } else {
          activeButton = page; // Set as active
          needPage = int.parse(page);
        }
      });
    },
    child: Text(
      page,
      style: TextStyle(color: isActive ? Colors.black : Colors.white),
    ),
    style: TextButton.styleFrom(
      backgroundColor: isActive ? Colors.white : mainColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
    ),
  );
}
}