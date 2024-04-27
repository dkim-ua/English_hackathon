import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:english_hakaton/class/constant.dart';
import 'package:english_hakaton/pages/general/home_page.dart';
import 'package:english_hakaton/pages/general/chat/person_of_chat_page.dart';
import 'package:english_hakaton/pages/general/profile/profile_page.dart';
import 'package:english_hakaton/pages/general/training/training_page.dart';
import 'package:english_hakaton/pages/general/vocabulary/vocabulary_page.dart';
import 'package:english_hakaton/route/route.gr.dart';
import 'package:flutter/material.dart';

import '../../class/voice_assistant_stt.dart';
import '../../enums/enum_current_state.dart';
import '../../theme/micro_button.dart';

late VoiceAssistantSpeechToText voiceAssistantSpeechToText;
bool isOnThisScreen = true;

@RoutePage()
class GeneralPage extends StatefulWidget {
  const GeneralPage({super.key});

  @override
  State<GeneralPage> createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {
  int currentPageIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    voiceAssistantSpeechToText = VoiceAssistantSpeechToText(
        language: languages[1],
        enumCurrentState: EnumCurrentState.courseCurrentState.serverType());
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
            Scaffold(
              bottomNavigationBar: NavigationBar(
                onDestinationSelected: (int index) {
                  isOnThisScreen ? setState(() {
                    currentPageIndex = index;
                  })
                  : null;
                },
                selectedIndex: currentPageIndex,
                backgroundColor: isOnThisScreen ? Colors.white : Colors.black.withOpacity(0.6),
                destinations: const <Widget>[
                  NavigationDestination(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.model_training_rounded),
                    label: 'Training',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.mark_chat_unread_outlined),
                    label: 'Chat',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.book),
                    label: 'Vocabulary',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
              ),
              body: <Widget>[
                ///Home page
                const HomePage(),
                /// Training page
                const TrainingPage(),
                /// Chat page
                const PersonOfChatPage(),
                /// Vocabulary page
                const VocabularyPage(),
                ///Profile page
                ListView(
                  children: <Widget>[
                    AppBar(
                      title: const Text('Профіль'),
                      actions: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.settings),
                          onPressed: () {voiceAssistantTextToSpeech.stop(); context.router.replace(SettingsRoute());},
                        ),
                      ],
                    ),
                    const UserHeader(),
                    const ProgressIndicatorSection(),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                        color: const Color(0xff173373).withOpacity(0.65),
                      ),
                      height: 500.0,
                      child: const ClassSection(),
                    ),
                  ],
                ),
              ][currentPageIndex],
            ),
        isVoiceAssistant && isOnThisScreen
            ? MicroButton(
          voiceAssistantSpeechToText: voiceAssistantSpeechToText,
          onTap: () {
            voiceAssistantSpeechToText.getRecognizing()
                ? setState(() {
                  navigationBarCurrentState(context, currentPageIndex).then((value) => setState(() {
                    currentPageIndex = value;
                  }));
                })
                : voiceAssistantSpeechToText.streamingRecognize();
          },
        )
            : const SizedBox()
      ],
    );
  }
}

Future<int> navigationBarCurrentState(BuildContext context, int currentPage) async {
  var result = await voiceAssistantSpeechToText.stopRecording();
  switch (result.toString()) {
    case "COURSE":
      print('ona skazala ДАМОЙ');
      return 0;
    case "TRAINING":
      print('ona skazala ГО ТРЕНИТЬ');
      return 1;
    case "CHAT_ASSISTANT":
      isOnThisScreen = false;
      print('ona skazala ПОПИЗДИМ');
      return 2;
    case "MY_DICTIONARY":
      print('ona skazala СЛОВАРЬ');
      return 3;
    case "PROFILE":
      print('ona skazala Я ЕЙ ИНТЕРЕСЕН');
      return 4;
    case "DISABLE_VOICE_ASSISTANT":
      isVoiceAssistant = false;
      print('ona skazala Я ЕЙ НАХУЙ НЕ НУЖЕН');
      return currentPage;
    case "REPEAT":
    // TODO
      ttsSpeakPage();
      return currentPage;
    case "UNDEFINED":
      voiceAssistantTextToSpeech.ttsUndefined();
      print('undefined');
      return currentPage;
  }
  return currentPage;
}