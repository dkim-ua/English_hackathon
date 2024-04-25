import 'package:english_hakaton/theme/main_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../class/constant.dart';
import '../../../class/voice_assistant_stt.dart';
import '../../../class/voise_assistant_tts.dart';

late VoiceAssistantSpeechToText voiceAssistantSpeechToText;

class UserHeader extends StatelessWidget {
  const UserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      leading: Icon(Icons.account_circle, size: 50),
      title: Text('Lera Mais', style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text('Pre-Intermediate'),
    );
  }
}

class ProgressIndicatorSection extends StatelessWidget {
  const ProgressIndicatorSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Unit 1'),
      subtitle: LinearProgressIndicator(
        value: 0.35,
        backgroundColor: backgroundColor,
        valueColor: AlwaysStoppedAnimation<Color>(mainColor),
      ),
      trailing: const Text('35%'),
    );
  }
}

class ClassSection extends StatefulWidget {
  const ClassSection({super.key});

  @override
  State<ClassSection> createState() => ClassSectionState();
}

class ClassSectionState extends State<ClassSection> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    voiceAssistantSpeechToText = VoiceAssistantSpeechToText(languages[1]);
    ttsSpeakStart();
  }

  @override
  Widget build(BuildContext context) {
    // Placeholder for the class section
    return ListView(
      children: <Widget>[
        Container(
            height: 250.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.all(15.0),
            child: SfCartesianChart(
                backgroundColor: backgroundColor,
                // Initialize category axis
                primaryXAxis: const CategoryAxis(),
                series: <LineSeries<SalesData, String>>[
                  LineSeries<SalesData, String>(
                    // Bind data source
                      dataSource:  <SalesData>[
                        SalesData('Mon', 5),
                        SalesData('Tue', 7),
                        SalesData('Wed', 3),
                        SalesData('Thu', 10),
                        SalesData('Fri', 6),
                        SalesData('Sat', 9),
                        SalesData('Sun', 3)
                      ],
                      xValueMapper: (SalesData sales, _) => sales.year,
                      yValueMapper: (SalesData sales, _) => sales.sales
                  )
                ]
            )
        ),
        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          padding: EdgeInsets.all(10.0),
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: helpColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text('Pre-Intermediate', textAlign: TextAlign.center),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: helpColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text('Pre-Intermediate', textAlign: TextAlign.center),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

void ttsSpeakStart(){
  ttsSpeak("Ви знаходитесь на сторінці Вашого профіля. "
      "Ви хочете дізнатись інформацію щодо свого профілю чи функціонал сторінки", languages[1]);
}
void ttsSpeak(String text, String language){
  if (isVoiceAssistant == true) {
    voiceAssistantTextToSpeech.speak(text, language);
  }
}