import 'package:auto_route/auto_route.dart';
import 'package:english_hakaton/class/voise_assistant_tts.dart';
import 'package:english_hakaton/enums/enum_chat.dart';
import 'package:english_hakaton/route/route.gr.dart';
import 'package:english_hakaton/theme/main_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../class/constant.dart';

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
    VoiceAssistantTextToSpeech().stop();
    ttsSpeakStart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

void ttsSpeakStart(){
  ttsSpeak("Ви знаходитесь на сторінці вибору чата. Оберіть чат", languages[1]);
}
void ttsSpeak(String text, String language){
  if (isVoiceAssistant == true) {
    VoiceAssistantTextToSpeech().speak(text, language);
  }
}