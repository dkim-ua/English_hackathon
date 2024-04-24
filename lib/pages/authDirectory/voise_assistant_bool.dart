import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:english_hakaton/class/constant.dart';
import 'package:english_hakaton/class/voise_assistant_tts.dart';
import 'package:english_hakaton/route/route.gr.dart';
import 'package:english_hakaton/theme/main_theme.dart';
import 'package:flutter/material.dart';

@RoutePage()
class VoiceAssistantPage extends StatefulWidget {
  const VoiceAssistantPage({super.key});

  @override
  State<VoiceAssistantPage> createState() => _VoiceAssistantPageState();
}

class _VoiceAssistantPageState extends State<VoiceAssistantPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    VoiceAssistantTextToSpeech().stop();
    ttsSpeakPage();
  }

  void ttsSpeakPage(){
    String helloWorld = 'Чи потрібен вам\nголосовий '
        'асистент для\nвивчення англійської мови?';
    VoiceAssistantTextToSpeech().speak(helloWorld, languages[1]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/images/background_robot.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 110.0,),
            const Text(
              'Чи потрібен вам\nголосовий асистент для\nвивчення англійської мови?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 48.0),
            ResponseButton(title: 'ТАК', onTap: () {
              isVoiceAssistant = true;
              VoiceAssistantTextToSpeech().stop();
              context.router.replace(const StartRoute());
              print('ona skazala DA');
            }),
            const SizedBox(height: 16.0),
            ResponseButton(title: 'НІ', onTap: () {
              isVoiceAssistant = false;
              context.router.replace(const StartRoute());
            }),
          ],
        ),
      ),
    );
  }
}

void getLansjrkgnr() async{
  try {
    var voices = await VoiceAssistantTextToSpeech().flutterTts.getVoices;
    if (voices != null) {
      var castVoices = voices.map<Map<String, dynamic>>((voice) {
        return Map<String, dynamic>.from(voice as Map);
      }).toList();
       var _availableVoices = castVoices.where((voiceMap) {
          String locale = voiceMap['locale'].toString().toLowerCase();
          return(locale.startsWith('uk'));
        }).map<String>((voiceMap) {
          return("${voiceMap['name']} | ${voiceMap['locale']}");
        }).toList();
       print(_availableVoices);
    }
  } on Exception catch (e) {
    print(e);
  }
}

class ResponseButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ResponseButton({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: mainColor,
        minimumSize: const Size(double.infinity, 56.0), // width and height
      ),
      onPressed: onTap,
      child: Text(
        title,
        style: const TextStyle(fontSize: 20.0, color: Colors.white),
      ),
    );
  }
}
