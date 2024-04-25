import 'package:auto_route/auto_route.dart';
import 'package:english_hakaton/route/route.gr.dart';
import 'package:english_hakaton/theme/main_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
@RoutePage()
class WordSetPage extends StatefulWidget {
  const WordSetPage({Key? key}) : super(key: key); // Const constructor

  @override
  _WordSetPageState createState() => _WordSetPageState();
}


class _WordSetPageState extends State<WordSetPage> {
  String userName = 'Words from lessons';


  List<LessonProgress> lessonProgressList = [
    LessonProgress(
      lessonName: 'Beginner',
      lessonNumber: 1,
      progress: 200,
      wordsProgress: 10,
      levels: [
        Level(name: "Animal",subLevel: 'A1', details: ["Lion", "Tiger","Eagle", "Parrot"]),
        Level(name: "Animal", subLevel: 'A2',details: ["Lion", "Tiger","Eagle", "Parrot"]),
        Level(name: "Sport", subLevel: 'A1',details: ["Pool", "Ball"]),
        Level(name: "Sport", subLevel: 'A2',details: ["Pool", "Ball"]),
        Level(name: "School", subLevel: 'A1',details: ["Notebook", "Pen","Teacher"]),
        Level(name: "School", subLevel: 'A2',details: ["Notebook", "Pen","Teacher"]),
      ],
    ),
    LessonProgress(
      lessonName: 'Intermediate',
      lessonNumber: 1,
      progress: 200,
      wordsProgress: 10,
      levels: [
        Level(name: "Animal",subLevel: 'B1', details: ["Lion", "Tiger","Eagle", "Parrot"]),
        Level(name: "Animal", subLevel: 'B2',details: ["Lion", "Tiger","Eagle", "Parrot"]),
        Level(name: "Sport", subLevel: 'B1',details: ["Pool", "Ball"]),
        Level(name: "Sport", subLevel: 'B2',details: ["Pool", "Ball"]),
        Level(name: "School", subLevel: 'B1',details: ["Notebook", "Pen","Teacher"]),
        Level(name: "School", subLevel: 'B2',details: ["Notebook", "Pen","Teacher"]),
      ],
    ),
    LessonProgress(
      lessonName: 'Advance',
      lessonNumber: 1,
      progress: 200,
      wordsProgress: 10,
      levels: [
        Level(name: "Animal",subLevel: 'C1', details: ["Lion", "Tiger","Eagle", "Parrot"]),
        Level(name: "Animal", subLevel: 'C2',details: ["Lion", "Tiger","Eagle", "Parrot"]),
        Level(name: "Sport", subLevel: 'C1',details: ["Pool", "Ball"]),
        Level(name: "Sport", subLevel: 'C2',details: ["Pool", "Ball"]),
        Level(name: "School", subLevel: 'C1',details: ["Notebook", "Pen","Teacher"]),
        Level(name: "School", subLevel: 'C2',details: ["Notebook", "Pen","Teacher"]),
      ],
    )
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userName),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,),
          onPressed: (){
            context.router.replace(GeneralRoute());
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            LessonSection(lessonProgressList: lessonProgressList),
          ],
        ),
      ),
    );
  }
}

class UserInfoSection extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
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
          SizedBox(height: 20.0,)
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
  String subLevel;
  List<String> details; // Assume 'details' are a list of strings

  Level({required this.name,required this.subLevel, required this.details});
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
          title: Row(
            children: [ // Additional icon
              SizedBox(width: 10), // Space between icons
              Expanded(child: Text(
                lesson.lessonName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              )),
            ],
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
      title: Row(
        children: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () {
              // Add your desired functionality here
              print('Adding detail for: ${level.name} ${level.subLevel}');
            },
          ),
          SizedBox(width: 8), // Space between the icon and text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(level.name, style: TextStyle(color: Colors.white)),
              Text(level.subLevel, style: TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
        ],
      ),
      backgroundColor: mainColor,
      iconColor: Colors.white,
      collapsedIconColor: Colors.white,
      children: level.details.map((detail) => ListTile(
        title: Text(detail, style: TextStyle(color: Colors.white)),
      )).toList(),
    );
  }

}




