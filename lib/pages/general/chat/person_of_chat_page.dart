import 'package:auto_route/auto_route.dart';
import 'package:english_hakaton/class/voise_assistant_tts.dart';
import 'package:english_hakaton/enums/enum_chat.dart';
import 'package:english_hakaton/enums/enum_current_state.dart';
import 'package:english_hakaton/enums/enum_responses_current_state.dart';
import 'package:english_hakaton/pages/general/general_page.dart';
import 'package:english_hakaton/pages/general/home_page.dart';
import 'package:english_hakaton/route/route.gr.dart';
import 'package:english_hakaton/theme/main_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../class/constant.dart';
import '../../../class/voice_assistant_stt.dart';
import '../../../theme/micro_button.dart';

late VoiceAssistantSpeechToText voiceAssistantSpeechToText;


@RoutePage()
class PersonOfChatPage extends StatefulWidget {
  const PersonOfChatPage({super.key});

  @override
  State<PersonOfChatPage> createState() => _PersonOfChatPageState();
}

class _PersonOfChatPageState extends State<PersonOfChatPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    voiceAssistantSpeechToText = VoiceAssistantSpeechToText(
        language: languages[1],
        enumCurrentState: EnumCurrentState.selectChatTypeCurrentState.serverType());
    ttsSpeakStart();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: mainColor,
          appBar: AppBar(
            title: const Text('Themes for chat'),
          ),
          body: ListView(
            children: <Widget>[
                _buildChatThemeTile('Hospital', 'Doctor', ChatType.hospital.serverType()),
                _buildChatThemeTile('Taxi', 'Taxi driver', ChatType.taxi.serverType()),
                _buildChatThemeTile('Restaurant', 'Waiter', ChatType.restaurant.serverType()),
                _buildChatThemeTile('Interview', 'Hiring manager', ChatType.interview.serverType()),
                _buildChatThemeTile('Hotel', 'Manager', ChatType.hotel.serverType()),
                _buildChatThemeTile('Date', 'English teacher', ChatType.friend.serverType()),
            ],
          ),
        ),
        isVoiceAssistant
            ? MicroButton(
          voiceAssistantSpeechToText: voiceAssistantSpeechToText,
          onTap: () {
            voiceAssistantSpeechToText.getRecognizing()
                ? navigationPersonOfChat(context)
                : voiceAssistantSpeechToText.streamingRecognize();
          },
        )
            : const SizedBox()
      ],
    );
  }

  Widget _buildChatThemeTile(String title, String subtitle, String chatType) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        leading: CircleAvatar(
          backgroundColor: mainColor,
          child: const Icon(Icons.chat_bubble_outline, color: Colors.white),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: () {
          // Handle the tap
          context.router.push(ChatRoute(subtitle: subtitle, chatType:  chatType));
        },
      ),
    );
  }
}

void navigationPersonOfChat(BuildContext context) async {
  var result = await voiceAssistantSpeechToText.stopRecording();
  switch (result.toString()) {
    case 'IN_HOSPITAL':
      print('ona skazala YA BOLNA');
      context.router.replace(ChatRoute(subtitle: 'Doctor', chatType: ChatType.hospital.serverType()));
    case "IN_TAXI":
      context.router.replace(ChatRoute(subtitle: 'Taxi driver', chatType: ChatType.taxi.serverType()));
      print('ona skazala TAXI 838');
    case "IN_RESTAURANT":
      context.router.push(ChatRoute(subtitle: 'Waiter', chatType: ChatType.restaurant.serverType()));
      print('ona skazala HOCHU HAVAT');
    case "IN_INTERVIEW":
      context.router.replace(ChatRoute(subtitle: 'Hiring manager', chatType: ChatType.interview.serverType()));
      print('ona skazala NA RABOTU');
    case "IN_HOTEL":
      context.router.replace(ChatRoute(subtitle: 'Manager', chatType: ChatType.hotel.serverType()));
      print('ona skazala ATEL');
    case "FIRS_DATE":
      context.router.replace(ChatRoute(subtitle: 'English teacher', chatType: ChatType.friend.serverType()));
      print('ona skazala POSHLI UCHITSA');
    case "COURSE":
      context.router.replace(GeneralRoute());
      print('ona skazala NAZAD');
    case "REPEAT":
    // TODO
      ttsSpeakStart();
    case "UNDEFINED":
      voiceAssistantTextToSpeech.ttsUndefined();
      print('undefined');
    case "DISABLE_VOICE_ASSISTANT":
      isVoiceAssistant = false;
      GeneralPage().createState();
      print('ona skazala Я ЕЙ НАХУЙ НЕ НУЖЕН');
  }
}

void ttsSpeakStart(){
  ttsSpeak("Ви знаходитесь на сторінці вибору чата. З ким ви хочете поспілкуватись: Доктор, Таксіст, Офіціант, Інтервьювер, Менеджер отелю чи подруга?", languages[1]);
}

void ttsSpeak(String text, String language){
  if (isVoiceAssistant == true) {
    voiceAssistantTextToSpeech.speak(text, language);
  }
}