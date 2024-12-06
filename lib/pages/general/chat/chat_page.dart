import 'dart:convert';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:english_hakaton/class/chat.dart';
import 'package:english_hakaton/class/voice_assistant_stt.dart';
import 'package:english_hakaton/enums/enum_responses_current_state.dart';
import 'package:english_hakaton/pages/general/general_page.dart';
import 'package:english_hakaton/route/route.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:http/http.dart' as http;
import 'package:shake/shake.dart';

import '../../../class/constant.dart';
import '../../../theme/micro_button.dart';

String textStt = '';
late VoiceAssistantSpeechToText voiceAssistantSpeechToText;

@RoutePage()
class ChatPage extends StatefulWidget {
  final String subtitle;
  final String chatType;

  const ChatPage({super.key, required this.subtitle, required this.chatType});

  @override
  _ChatPageState createState() => _ChatPageState();
}

ChatModel? chat;

class _ChatPageState extends State<ChatPage> {
  List<types.Message> _messages = [];
  final _user = const types.User(id: 'user1');
  final _user2 = const types.User(id: 'user2');
  bool _isProcessing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    voiceAssistantTextToSpeech.stop();
    ShakeDetector detector = ShakeDetector.autoStart(
      onPhoneShake: () {
        // Do stuff on phone shake
        isOnThisScreen = true;
        context.router.replace(const GeneralRoute());
      },
      minimumShakeCount: 2,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );
    voiceAssistantSpeechToText = VoiceAssistantSpeechToText(
        language: languages[0],
        enumCurrentState: EnumResponseCurrentState.chatAssistant.serverType());

    ///TODO!!!!!!!!!!!!!!!!
    _initChat();
  }

  Future<void> _initChat() async {
    await ttsSpeakStart();
    ChatModel? fetchedChat = await firstMessage(widget.chatType);
    setState(() {
      chat = fetchedChat;
      _answer(chat?.textMessege,
          languages[0]); // Only call this after ensuring chat is not null
    });
  }

  void _question(types.PartialText message) {
    if (_isProcessing) {
      return; // Stop further execution if a request is already processing
    }
    _isProcessing = true;

    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: DateTime.now().toIso8601String(),
      text: message.text,
    );

    // Add the user's message to the chat
    setState(() {
      _messages.insert(0, textMessage);
    });

    fetchData(message.text).then((answer) {
      _answer(answer, message.text.toLowerCase().contains('translate') ? languages[1] : languages[0]);
    }).catchError((error) {
      print('Error sending message: $error');
    }).whenComplete(() {
      _isProcessing = false; // Always turn off processing indicator
      setState(() {}); // Update the UI once operation is complete
    });
  }

  void _answer(String answerText, String language) {
    final textMessage = types.TextMessage(
      author: _user2,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: DateTime.now().toIso8601String(),
      text: answerText,
    );

    // Update UI to show the assistant's response
    setState(() {
      _messages.insert(0, textMessage);
      ttsSpeak(textMessage.text, language);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(title: Text(widget.subtitle)),
          body: Stack(
            children: [
              Chat(
                messages: _messages,
                onSendPressed: _question,
                user: _user,
              ),
              if (_isProcessing) // Correct usage of collection if
                Positioned(
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.black54,
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        ),
        isVoiceAssistant
            ? MicroButton(
          voiceAssistantSpeechToText: voiceAssistantSpeechToText,
          onTap: () {
            processVoice();
          },
        )
            : const SizedBox()
      ],
    );
  }

  Future<void> processVoice() async {
    if (voiceAssistantSpeechToText.getRecognizing()) {
      // Stop the recording and wait for it to complete
      await voiceAssistantSpeechToText.stopRecording();
      if (voiceAssistantSpeechToText.text.isNotEmpty) {
        // Process the recognized text only if it is not empty
        final partialText = types.PartialText(text: voiceAssistantSpeechToText.text);
        _question(partialText); // Handle the question with the recognized text
      }
    } else {
      // Start recording and do not proceed until it's started
      await voiceAssistantSpeechToText.streamingRecognize();
    }
  }
}

Future<ChatModel> firstMessage(String theme) async {
  var url = Uri.parse('http://$baseIP/api/v1/chat-assistant/new-chat');
  var params = {'theme': theme, 'user_id': '1'};

  try {
    var response = await http.post(
      url,
      body: params,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponseChat = jsonDecode(response.body);

      print('Ответ сервера: $jsonResponseChat');
      var chatModel =
          ChatModel(jsonResponseChat["chat-id"], jsonResponseChat["message"]);
      return chatModel;
    } else {
      return ChatModel(0, 'Ошибка: ${response.statusCode}');
    }
  } catch (e) {
    return ChatModel(0, 'Ошибка при выполнении запроса: $e');
  }
}

Future<String> fetchData(String newMessageText) async {
  final response =
      await http.get(Uri.http(baseIP, '/api/v1/chat-assistant/get-response', {
    'chat-id': chat?.chatId.toString(), // Replace with your chatId
    'user-id': '1', // Replace with your userId
    'new-message-text': newMessageText, // Replace with your message text
  }));

  try {
    if (response.statusCode == 200) {
      //Map<String, dynamic> jsonResponseChat = jsonDecode(response.body);

      print('Ответ сервера: ${response.body}');
      var answer = response.body;
      return answer;
    } else {
      return 'Error: ${response.statusCode}';
    }
  } catch (e) {
    return 'Error during the request: $e';
  }
}

Future<void> ttsSpeakStart() async {
  if (isVoiceAssistant == true) {
    await voiceAssistantTextToSpeech.speak(
        'Чат обрано! Щоб повернутися на головну - потрясіть екраном! Чат працює тільки англійською мовою скажіть', languages[1]);
    voiceAssistantTextToSpeech.speak('translate', languages[0]);
    await voiceAssistantTextToSpeech.stop();
    voiceAssistantTextToSpeech.speak('для отримання перекладу', languages[1]);
    await voiceAssistantTextToSpeech.stop();
  }
}

void ttsSpeak(String text, String language) {
  if (isVoiceAssistant == true) {
    voiceAssistantTextToSpeech.speak(text, language);
  }
}
