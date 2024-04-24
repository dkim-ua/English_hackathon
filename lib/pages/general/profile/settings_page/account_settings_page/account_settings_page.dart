import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

import '../../../../../class/constant.dart';
import '../../../../../class/voise_assistant_tts.dart';

@RoutePage()
class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    VoiceAssistantTextToSpeech().stop();
    ttsSpeakStart();
  }
  final TextEditingController _nameController = TextEditingController(text: 'Баклажан');
  final TextEditingController _emailController = TextEditingController(text: 'mva9727@gmail.com');
  int _age = 19;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[300],
              child: const Icon(
                Icons.person,
                size: 50,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Gender: '),
                Radio<String>(
                  value: 'male',
                  groupValue: null,
                  onChanged: null,
                ),
                const Text('Male'),
                Radio<String>(
                  value: 'female',
                  groupValue: null,
                  onChanged: null,
                ),
                const Text('Female'),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: TextEditingController(text: _age.toString()),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Age',
              ),
              onChanged: (value) {
                setState(() {
                  _age = int.tryParse(value) ?? 0;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
void ttsSpeakStart(){
  ttsSpeak("Ви знаходитесь на сторінці налаштування профіля. "
      "Ви хочете дізнатись інформацію щодо свого профілю чи функціонал сторінки", languages[1]);
}
void ttsSpeak(String text, String language){
  if (isVoiceAssistant == true) {
    VoiceAssistantTextToSpeech().speak(text, language);
  }
}