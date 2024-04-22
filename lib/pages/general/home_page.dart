import 'package:english_hakaton/theme/main_theme.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Column(
        children: [
          Text(
            'UNIT 1',
              style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
      ),
        ),
          Text(
            'поговоримо про бабаблабала',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    ),
        body: _LessonList(),
    );
  }
}

class _LessonList extends StatelessWidget {
  final List<Lesson> lessons = [
    Lesson(title: 'Lesson 1', subtitle: 'Shop and Shopping', bottomTitle: 'Gerund & Infinitive', isCompleted: true),
    Lesson(title: 'Lesson 2', subtitle: 'Sences', bottomTitle: 'See...'),
    Lesson(title: 'Lesson 3', subtitle: 'Sences', bottomTitle: 'See...'),
    Lesson(title: 'Lesson 4', subtitle: 'Sences', bottomTitle: 'See...'),
    Lesson(title: 'Lesson 5', subtitle: 'Sences', bottomTitle: 'See...'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(15),
      itemCount: lessons.length,
      itemBuilder: (BuildContext context, int index) {
        return LessonTile(lesson: lessons[index]);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
class Lesson {
  final String title;
  final String subtitle;
  final String bottomTitle;
  final bool isCompleted;

  Lesson({
    required this.title,
    required this.subtitle,
    required this.bottomTitle,
    this.isCompleted = false,
  });
}
class LessonTile extends StatelessWidget {
  final Lesson lesson;

  const LessonTile({
    Key? key,
    required this.lesson,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xff183473).withOpacity(0.65),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: (lesson.isCompleted ? iconChecked : iconUnchecked),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lesson.title,
              style: TextStyle(
                fontSize: 15.0,
                color: lessons_color,
              ),
            ),
            Text(
              lesson.subtitle,
              style: TextStyle(
                fontSize: 19.0,
                color: Colors.white,
              ),
            ),
            Text(
              lesson.bottomTitle,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
        onTap: () {
          // Navigate to lesson details or perform an action
        },
      ),
    );
  }
}
