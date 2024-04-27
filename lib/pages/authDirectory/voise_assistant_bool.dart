import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:english_hakaton/class/constant.dart';
import 'package:english_hakaton/class/voice_assistant_stt.dart';
import 'package:english_hakaton/enums/enum_current_state.dart';
import 'package:english_hakaton/route/route.gr.dart';
import 'package:english_hakaton/theme/main_theme.dart';
import 'package:english_hakaton/theme/micro_button.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

late VoiceAssistantSpeechToText voiceAssistantSpeechToText;
late Function() onTapYes;
late Function() onTapNo;

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
    Permission.microphone.request();
    voiceAssistantSpeechToText = VoiceAssistantSpeechToText(
        language: languages[1],
        enumCurrentState:
            EnumCurrentState.voiceAssistantCurrentState.serverType());
    voiceAssistantTextToSpeech.initTts();
    ttsSpeakPage();
  }

  void ttsSpeakPage() {
    String helloWorld = 'Чи потрібен вам\nголосовий '
        'асистент для\nкерування додатком? Натисніть на екран та після вібрації скажіть так або ні, після чого - ще раз натисніть на екран';
    voiceAssistantTextToSpeech.speak(helloWorld, languages[1]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/images/background_robot.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 110.0,
                ),
                const Text(
                  'Чи потрібен вам\nголосовий асистент для\nвивчення англійської мови?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 48.0),
                ResponseButton(
                    title: 'ТАК',
                    onTap: () {
                      isVoiceAssistant = true;
                      voiceAssistantTextToSpeech.stop();
                      context.router.replace(const StartRoute());
                      print('ona skazala DA');
                    }),
                const SizedBox(height: 16.0),
                ResponseButton(
                    title: 'НІ',
                    onTap: () {
                      isVoiceAssistant = false;
                      context.router.replace(const StartRoute());
                    }),
              ],
            ),
          ),
          isVoiceAssistant
              ? MicroButton(
                  voiceAssistantSpeechToText: voiceAssistantSpeechToText,
                  onTap: () {
                    voiceAssistantSpeechToText.getRecognizing()
                        ? YesNoUndefined(context)
                        : voiceAssistantSpeechToText.streamingRecognize();
                  },
                )
              : const SizedBox()
        ],
      ),
    );
  }
}

void YesNoUndefined(BuildContext context) async{
  var result = await voiceAssistantSpeechToText.stopRecording();
  switch(result.toString()){
    case "YES":
        isVoiceAssistant = true;
        voiceAssistantTextToSpeech.stop();
        context.router.replace(const StartRoute());
        print('ona skazala DA');
    case "NO":
      isVoiceAssistant = false;
      voiceAssistantTextToSpeech.stop();
      context.router.replace(const GeneralRoute());
      print('ona skazala NOOOOO');
    case "UNDEFINED":
      voiceAssistantTextToSpeech.stop();
      voiceAssistantTextToSpeech.ttsUndefined();
      print('undefined');
  }
}

void getLansjrkgnr() async {
  try {
    var voices = await voiceAssistantTextToSpeech.flutterTts.getVoices;
    if (voices != null) {
      var castVoices = voices.map<Map<String, dynamic>>((voice) {
        return Map<String, dynamic>.from(voice as Map);
      }).toList();
      var _availableVoices = castVoices.where((voiceMap) {
        String locale = voiceMap['locale'].toString().toLowerCase();
        return (locale.startsWith('uk'));
      }).map<String>((voiceMap) {
        return ("${voiceMap['name']} | ${voiceMap['locale']}");
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
