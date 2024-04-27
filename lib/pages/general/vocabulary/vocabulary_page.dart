import 'dart:convert';

import 'package:english_hakaton/enums/enum_current_state.dart';
import 'package:english_hakaton/theme/main_theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../class/constant.dart';
import '../../../class/voice_assistant_stt.dart';
import '../../../class/voise_assistant_tts.dart';

late VoiceAssistantSpeechToText voiceAssistantSpeechToText;

class VocabularyPage extends StatefulWidget {
  const VocabularyPage({super.key});

  @override
  State<VocabularyPage> createState() => _VocabularyPageState();
}

class _VocabularyPageState extends State<VocabularyPage> {
  Map<String, dynamic> wordsMapResponse = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    () async {
      try {
        wordsMapResponse = await fetchData(1, 25);

        print(wordsMapResponse.toString());
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        print('Error: $e');
      }
    }();
    voiceAssistantSpeechToText = VoiceAssistantSpeechToText(
        language: languages[1],
        enumCurrentState: EnumCurrentState.courseCurrentState.serverType());
    ttsSpeakStart();
  }

  @override
  Widget build(BuildContext context) {

    if (isLoading == true) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    } else {
      return Scaffold(
        appBar: AppBar(title: const Text('BEEPER')),
        body: ListView(
          padding: EdgeInsets.all(5.0),
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              // Constrain the height of the PieChart
              height: 200, // Set this height to fit your design
              child: PieChart(
                PieChartData(
                  sectionsSpace: 0,
                  centerSpaceRadius: 70,
                  sections: [
                    PieChartSectionData(
                        value: 130,
                        color: Colors.green,
                        title: '130',
                        radius: 50),
                    PieChartSectionData(
                        value: 73, color: Colors.yellow, title: '73', radius: 50),
                    PieChartSectionData(
                        value: 56, color: Colors.grey, title: '56', radius: 50),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: mainColor,
              ),
              padding: const EdgeInsets.all(15.0),
              child: Column(children: <Widget>[
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
                      style: ElevatedButton.styleFrom(
                          backgroundColor: backgroundColor),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('ADD WORDS'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: backgroundColor),
                    ),
                  ],
                )
              ]),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: mainColor,
              ),
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: wordsMapResponse.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      children: [_buildLessonProgress(entry)],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      );
    }


  } // widgetBuild

  Widget _buildStatisticText(String text, Color color) {
    return Text(
      text,
      style: TextStyle(color: color, fontWeight: FontWeight.bold),
    );
  }

  Card _buildLessonProgress(var entry) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ListTile(
        title: Text(entry.key),
        subtitle: LinearProgressIndicator(
          value: entry.value / 5,
          backgroundColor: Colors.grey[300],
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
        trailing: Text('${entry.value}/5'),
      ),
    );
  }

  Future<Map<String, dynamic>> fetchData(int page, int pageSize) async {
    final response = await http.get(Uri.http(baseIP, '/page-for-user', {
      'user-id': '1',
      'page': page.toString(), // Convert to string
      'page-size': pageSize.toString(), // Convert to string
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
}

void ttsSpeakStart(){
  ttsSpeak("Ви знаходитесь на сторінці Словника. ", languages[1]);
}
void ttsSpeak(String text, String language){
  if (isVoiceAssistant == true) {
    voiceAssistantTextToSpeech.speak(text, language);
  }
}
