import 'package:english_hakaton/theme/main_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

class VocabularyPage extends StatefulWidget {
  const VocabularyPage({Key? key}) : super(key: key); // Const constructor

  @override
  _VocabularyPageState createState() => _VocabularyPageState();
}


class _VocabularyPageState extends State<VocabularyPage> {
  String userName = 'DAVID NEGR';
  String userCourse = 'Lera Mais';
  int wordsLearned = 210;
  int totalWords = 270;
  int wordsToStudy = 130;
  int wordsToRepeat = 73;

  List<LessonProgress> lessonProgressList = [
    LessonProgress(
      lessonName: 'Beginner',
      lessonNumber: 1,
      progress: 200,
      wordsProgress: 10,
      levels: [
        Level(name: "Animal", details: ["Lion", "Tiger","Eagle", "Parrot"]),
        Level(name: "Sport", details: ["Pool", "Ball"]),
        Level(name: "School", details: ["Notebook", "Pen","Teacher"]),
      ],
    ),
    LessonProgress(
      lessonName: 'Intermediate',
      lessonNumber: 1,
      progress: 200,
      wordsProgress: 10,
      levels: [
        Level(name: "Animal", details: ["Lion", "Tiger","Eagle", "Parrot"]),
        Level(name: "Sport", details: ["Pool", "Ball"]),
        Level(name: "School", details: ["Notebook", "Pen","Teacher"]),
      ],
    ),
    LessonProgress(
      lessonName: 'Advance',
      lessonNumber: 1,
      progress: 200,
      wordsProgress: 10,
      levels: [
        Level(name: "Animal", details: ["Lion", "Tiger","Eagle", "Parrot"]),
        Level(name: "Sport", details: ["Pool", "Ball"]),
        Level(name: "School", details: ["Notebook", "Pen","Teacher"]),
      ],
    )
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userName),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            UserInfoSection(userCourse: userCourse, wordsLearned: wordsLearned, totalWords: totalWords, wordsToStudy: wordsToStudy, wordsToRepeat: wordsToRepeat),
            LessonSection(lessonProgressList: lessonProgressList),
          ],
        ),
      ),
    );
  }
}

class UserInfoSection extends StatelessWidget {
  const UserInfoSection({
    Key? key,
    required this.userCourse,
    required this.wordsLearned,
    required this.totalWords,
    required this.wordsToStudy,
    required this.wordsToRepeat,
  }) : super(key: key);

  final String userCourse;
  final int wordsLearned;
  final int totalWords;
  final int wordsToStudy;
  final int wordsToRepeat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(10),
        ),
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
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              buttonPadding: EdgeInsets.zero,
              children: [
                _buildButton(
                    context, 'Study', wordsToStudy.toString(), Colors.white),
                _buildButton(context, 'Repeat', wordsToRepeat.toString(),
                    Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton _buildButton(BuildContext context, String text, String count,
      Color color) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // Use backgroundColor instead of primary
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      onPressed: () {
        // Handle button press
      },
      child: Text('$text $count',style: TextStyle(color: Colors.black),),
    );
  }
}

class LessonSection extends StatefulWidget {
  final List<LessonProgress> lessonProgressList;

  const LessonSection({
    Key? key,
    required this.lessonProgressList,
  }) : super(key: key);

  @override
  _LessonSectionState createState() => _LessonSectionState();
}

class _LessonSectionState extends State<LessonSection> {
  int? _expandedTileIndex; // null means no tile is expanded

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Words from lessons',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.lessonProgressList.length,
            itemBuilder: (context, index) {
              final lesson = widget.lessonProgressList[index];
              bool isExpanded = index == _expandedTileIndex;
              return LessonButton(
                lesson: lesson,
                isExpanded: isExpanded,
                onExpansionChanged: (bool expanded) {
                  setState(() {
                    if (expanded) {
                      _expandedTileIndex = index;
                    } else if (!expanded && _expandedTileIndex == index) {
                      _expandedTileIndex = null;
                    }
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }
}


class LessonProgress {
  final String lessonName;
  final int lessonNumber;
  final double progress;
  final double wordsProgress;
  final List<Level> levels;  // Now a list of Level objects, not strings

  LessonProgress({
    required this.lessonName,
    required this.lessonNumber,
    required this.progress,
    required this.wordsProgress,
    required this.levels,
  });
}

class Level {
  String name;
  List<String> details; // Assume 'details' are a list of strings

  Level({required this.name, required this.details});
}

class LessonButton extends StatelessWidget {
  final LessonProgress lesson;
  final bool isExpanded;
  final Function(bool) onExpansionChanged;

  const LessonButton({
    Key? key,
    required this.lesson,
    required this.isExpanded,
    required this.onExpansionChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ExpansionTile(
          initiallyExpanded: isExpanded,
          onExpansionChanged: onExpansionChanged,
          title: Text(
            lesson.lessonName,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          iconColor: Colors.white,
          collapsedIconColor: Colors.white,
          backgroundColor: mainColor,
          collapsedBackgroundColor: mainColor,
          children: lesson.levels.map((level) => _buildNestedExpansionTile(level)).toList(),
        ),
      ),
    );
  }

  Widget _buildNestedExpansionTile(Level level) {
    return ExpansionTile(
      title: Text(level.name, style: TextStyle(color: Colors.white)),
      backgroundColor: mainColor,
      iconColor: Colors.white,
      collapsedIconColor: Colors.white,
      children: level.details.map((detail) => ListTile(
        title: Text(detail, style: TextStyle(color: Colors.white)),
      )).toList(),
    );
  }
}



