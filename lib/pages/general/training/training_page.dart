import 'package:auto_route/annotations.dart';
import 'package:english_hakaton/theme/main_theme.dart';
import 'package:flutter/material.dart';

import '../../../class/constant.dart';
import '../../../class/voice_assistant_stt.dart';
import '../../../class/voise_assistant_tts.dart';

late VoiceAssistantSpeechToText voiceAssistantSpeechToText;

@RoutePage()
class TrainingPage extends StatefulWidget {
  const TrainingPage({super.key});

  @override
  State<TrainingPage> createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    voiceAssistantSpeechToText = VoiceAssistantSpeechToText(languages[1]);
    ttsSpeakStart();
  }

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
    return Column(
      children: [
        SizedBox(height: 50), // Add spacing here
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(15),
            itemCount: lessons.length,
            itemBuilder: (BuildContext context, int index) {
              return LessonTile(lesson: lessons[index], index: index);
            },
            separatorBuilder: (BuildContext context, int index) =>
            const Divider(),
          ),
        ),
      ],
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
      child: Column(
        children: [
          ListTile(
            leading: images[index],
            title: Text(_LessonList().lessons[index]),
            textColor: Colors.white,
            onTap: () {
              // Navigate to lesson details or perform an action
            },
          ),
        ],
      ),
    );
  }
}

void ttsSpeakStart(){
  ttsSpeak("Ви знаходитесь на сторінці Тренувань. Хочете обрати тренування?", languages[1]);
}
void ttsSpeak(String text, String language){
  if (isVoiceAssistant == true) {
    voiceAssistantTextToSpeech.speak(text, language);
  }
}