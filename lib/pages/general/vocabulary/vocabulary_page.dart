import 'package:english_hakaton/theme/main_theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VocabularyPage extends StatefulWidget {
  const VocabularyPage({super.key});

  @override
  State<VocabularyPage> createState() => _VocabularyPageState();
}

class _VocabularyPageState extends State<VocabularyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BEEPER')),
      body: ListView(
        padding: EdgeInsets.all(5.0),
        children: [
          const SizedBox(height: 20,),
          SizedBox( // Constrain the height of the PieChart
            height: 200, // Set this height to fit your design
            child: PieChart(
              PieChartData(
                sectionsSpace: 0,
                centerSpaceRadius: 70,
                sections: [
                  PieChartSectionData(value: 130, color: Colors.green, title: '130', radius: 50),
                  PieChartSectionData(value: 73, color: Colors.yellow, title: '73', radius: 50),
                  PieChartSectionData(value: 56, color: Colors.grey, title: '56', radius: 50),
                ],
              ),
            ),
          ),
          const SizedBox(height: 25,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: mainColor,
            ),
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatisticText('130 learned', Colors.green),
                    _buildStatisticText('73 repeat', Colors.yellow),
                    _buildStatisticText('56 words to study', Colors.grey),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('STUDY'),
                      style: ElevatedButton.styleFrom(backgroundColor: backgroundColor),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('ADD WORDS'),
                      style: ElevatedButton.styleFrom(backgroundColor: backgroundColor),
                    ),
                  ],
                )
              ]
            ),
          ),
          const SizedBox(height: 10.0,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: mainColor,
            ),
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                _buildLessonProgress('Lesson 3 Transport', 3, 5),
                _buildLessonProgress('Lesson 3 Transport', 0, 5),
                _buildLessonProgress('Lesson 3 Transport', 4, 5),
                _buildLessonProgress('Lesson 3 Transport', 1, 5),
                _buildLessonProgress('Lesson 3 Transport', 5, 5),
                _buildLessonProgress('Lesson 3 Transport', 3, 5),
                _buildLessonProgress('Lesson 3 Transport', 0, 5),
                _buildLessonProgress('Lesson 3 Transport', 2, 5),
                _buildLessonProgress('Lesson 3 Transport', 5, 5),
                _buildLessonProgress('Lesson 3 Transport', 1, 5),
                _buildLessonProgress('Lesson 3 Transport', 4, 5),
                _buildLessonProgress('Lesson 3 Transport', 5, 5),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticText(String text, Color color) {
    return Text(text, style: TextStyle(color: color, fontWeight: FontWeight.bold),);
  }

  Widget _buildLessonProgress(String lessonName, int completed, int total) {
    return ListTile(
      title: Text(lessonName),
      subtitle: LinearProgressIndicator(
        value: completed / total,
        backgroundColor: Colors.grey[300],
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
      ),
      trailing: Text('$completed/$total'),
    );
  }
}