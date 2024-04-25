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
  static const String baseIP = '192.168.137.1:7050';

  final String userName = 'DAVID NEGR';
  final String userCourse = 'Lera Mais';
  final int wordsLearned = 210;
  final int totalWords = 270;
  final int wordsToStudy = 130;
  final int wordsToRepeat = 73;

  Future<Map<String, dynamic>> fetchData(int page, int pageSize) async {
    final response = await http.get(Uri.http(baseIP, '/page-for-user', {
      'user-id': '1',
      'page': page.toString(),
      'page-size': pageSize.toString(),
    }));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
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
        future: fetchData(1, 25),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          }

          Map<String, dynamic> wordsMapResponse = snapshot.data!;

          return ListView(
            padding: EdgeInsets.all(5.0),
            children: [
              // User Info and Progress
              _buildUserInfoSection(),

              // Other UI elements like buttons...
              // ...

              // Lessons Progress List
              ...wordsMapResponse.entries.map((entry) {
                return _buildLessonProgress(entry.key, entry.value);
              }).toList(),
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
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 8),
          Text('Learned $wordsLearned/$totalWords words',style: TextStyle(color: Colors.white),),
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
          Container(decoration: BoxDecoration(
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
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        title: Text(title),
        subtitle: LinearProgressIndicator(
          value: (value ?? 0) / 5, // Use the actual value or a placeholder
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
        trailing: Text('${value ?? 0}/5'), // Use the actual value or a placeholder
      ),
    );
  }
}
