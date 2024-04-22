import 'package:english_hakaton/theme/main_theme.dart';
import 'package:flutter/material.dart';

class TrainingPage extends StatefulWidget {
  const TrainingPage({super.key});

  @override
  State<TrainingPage> createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _LessonList(),
    );
  }
}

class _LessonList extends StatelessWidget {
  final List<String> lessons = [
    'Reading',
    'Speaking',
    'Listening',
    'Writing',
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

final List<Image> images = [
  readingTrainingIcon,
  speakingTrainingIcon,
  listeningTrainingIcon,
  writingTrainingIcon,
];

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
        color: trainingTileColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: images[index],
        title: Text(_LessonList().lessons[index]),
        textColor: Colors.white,
        onTap: () {
          // Navigate to lesson details or perform an action
        },
      ),
    );
  }
}
