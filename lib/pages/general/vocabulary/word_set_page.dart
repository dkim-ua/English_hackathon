import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:english_hakaton/route/route.gr.dart';
import 'package:english_hakaton/theme/main_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart' as http;

@RoutePage()
class WordSetPage extends StatefulWidget {
  const WordSetPage({Key? key}) : super(key: key); // Const constructor

  @override
  WordSetPageState createState() => WordSetPageState();
}

class WordSetPageState extends State<WordSetPage> {
  String userName = 'Words from lessons';
  static const String baseIP = '91.199.45.37:7050';
  static List<dynamic> wordSetLevelsForBeginner = List.empty();
  static List<dynamic> wordSetLevelsForIntermediate = List.empty();
  static List<dynamic> wordSetLevelsForAdvance = List.empty();
  static List<dynamic> wordSet = List.empty();

  late Future<void> _loadData;

// Define the isLoading flag
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      setState(() { isLoading = true; });
      await fetchWordSetsByLevel("BEGINNER");
      await fetchWordSetsByLevel("INTERMEDIATE");
      await fetchWordSetsByLevel("ADVANCED");
      print(wordSetLevelsForBeginner.toString());
      createLessonProgressList(); // Assuming this sets up lessonProgressList properly
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      setState(() { isLoading = false; });
    }
  }


  static List<LessonProgress> lessonProgressList = [
    createLessonProgress("BEGINNER", wordSetLevelsForBeginner),
    createLessonProgress("INTERMEDIATE", wordSetLevelsForIntermediate),
    createLessonProgress("ADVANCED", wordSetLevelsForAdvance)
  ];

  void createLessonProgressList() {
    setState(() {
      lessonProgressList = [
        createLessonProgress("BEGINNER", wordSetLevelsForBeginner),
        createLessonProgress("INTERMEDIATE", wordSetLevelsForIntermediate),
        createLessonProgress("ADVANCED", wordSetLevelsForAdvance)
      ];
    });
  }


  static Future<void> fetchWordSetsByLevel(String level) async {
    final response = await http.get(Uri.http(baseIP, '/api/v1/word-set/get-word-sets-by-level', {
      'english-level': level,
    }));

    try {
      if (response.statusCode == 200) {
        var fetchedWordSets = jsonDecode(response.body);
        if (level == "BEGINNER") {
          wordSetLevelsForBeginner = fetchedWordSets;
        } else if (level == "INTERMEDIATE") {
          wordSetLevelsForIntermediate = fetchedWordSets;
        } else if (level == "ADVANCED") {
          wordSetLevelsForAdvance = fetchedWordSets;
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data $e');
    }
  }


  static Future<List<dynamic>> fetchWordSetByName(String name) async {
    final response =
    await http.get(Uri.http(baseIP, '/api/v1/word-set/by-name', {
      'name': name,
    }));

    try {
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data $e');
    }
  }

  static Future<int> addWordsFromWordSet(int userId, String name) async {
    final response = await http
        .post(Uri.http(baseIP, '/api/v1/user/add-words-from-word-set', {
      'user-id': userId.toString(),
      'name': name,
    }));

    try {
      return response.statusCode;
    } catch (e) {
      throw Exception('Failed to load data $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Words from lessons'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.router.replace(GeneralRoute());
          },
        ),
      ),
      body: isLoading
          ? Center(
        // Show a loading indicator if isLoading is true
        child: CircularProgressIndicator(),
      )
          : SingleChildScrollView(
        child: Column(
          children: [
            // Your content goes here
            LessonSection(lessonProgressList: lessonProgressList),
          ],
        ),
      ),
    );
  }
}

LessonProgress createLessonProgress(
    String lvl, List<dynamic> wordSetLvl) {
  List<Level> levels = List.empty(growable: true);

  for (var item in wordSetLvl) {
    var parts = item.split(', ');
    if (parts.length == 2) {
      final uri = Uri.http(WordSetPageState.baseIP, '/api/v1/word-set/by-name', {
        'name': item,
      });

      http.get(uri).then((response) {
        if (response.statusCode == 200) {
          levels.add(Level(
              name: parts[0],
              subLevel: parts[1],
              details: jsonDecode(response.body)));
        } else {
          // Handle the error case
          print('Request failed with status: ${response.statusCode}');
        }
      }).catchError((error) {
        // Handle the error case
        print('Error: $error');
      });
    }
  }
  levels.sort((a,b) => a.name.compareTo(b.name));
  return LessonProgress(lessonName: lvl, levels: levels,);
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
          SizedBox(
            height: 20.0,
          )
        ],
      ),
    );
  }
}

class LessonProgress extends StatelessWidget {
  final String lessonName;
  final List<Level> levels; // Now a list of Level objects, not strings

  LessonProgress({
    required this.lessonName,
    required this.levels,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class Level extends StatelessWidget {
  dynamic name;
  dynamic subLevel;
  List<dynamic> details; // Assume 'details' are a list of strings

  Level({required this.name, required this.subLevel, required this.details});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
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
    List<Level> sortedLevels = lesson.levels.toList()
      ..sort((a, b) => a.name.compareTo(b.name) != 0
          ? a.name.compareTo(b.name)
          : a.subLevel.compareTo(b.subLevel));

    return Card(
      margin: EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ExpansionTile(
          initiallyExpanded: isExpanded,
          onExpansionChanged: onExpansionChanged,
          title: Row(
            children: [
              // Additional icon
              SizedBox(width: 10), // Space between icons
              Expanded(
                  child: Text(
                    lesson.lessonName,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
            ],
          ),
          iconColor: Colors.white,
          collapsedIconColor: Colors.white,
          backgroundColor: mainColor,
          collapsedBackgroundColor: mainColor,
          children: sortedLevels
              .map((level) => _buildNestedExpansionTile(level))
              .toList(),
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
              WordSetPageState.addWordsFromWordSet(1, level.name + ", " +level.subLevel);
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
      children: level.details
          .map((detail) => ListTile(
        title: Text(detail, style: TextStyle(color: Colors.white)),
      ))
          .toList(),
    );
  }
}