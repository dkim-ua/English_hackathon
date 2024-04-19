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
        title: Text('UNIT 1'),
      ),
      body: _LessonList(),
    );
  }
}

class _LessonList extends StatelessWidget {
  final List<String> lessons = [
    'Shop and Shopping',
    'Sences',
    'Sences',
    'Sences',
    'Sences',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: lessons.length,
      itemBuilder: (BuildContext context, int index) {
        return LessonTile(lesson: lessons[index], index: index);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}

class LessonTile extends StatelessWidget {
  final String lesson;
  final int index;

  const LessonTile({
    Key? key,
    required this.lesson,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(index == 0 ? Icons.check_circle : Icons.radio_button_unchecked),
        title: Text('Lesson ${index + 1}'),
        subtitle: Text(lesson),
        trailing: Icon(Icons.chevron_right),
        onTap: () {
          // Navigate to lesson details or perform an action
        },
      ),
    );
  }
}
