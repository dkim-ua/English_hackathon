import 'dart:convert';

import 'package:auto_route/annotations.dart';
import 'package:english_hakaton/class/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:http/http.dart' as http;

const String baseIP = '192.168.137.1:7050';

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
    _initChat();
  }

  Future<void> _initChat() async {
    ChatModel? fetchedChat = await firstMessage(widget.chatType);
    if (fetchedChat != null) {
      setState(() {
        chat = fetchedChat;
        _answer(chat?.textMessege); // Only call this after ensuring chat is not null
      });
    }
  }

  void _question(types.PartialText message) {
    if (_isProcessing) {
      return; // Если идет обработка, прерываем выполнение функции
    }

    _isProcessing = true;

    if (chat != null) {
      fetchData(message.text).then((textMessage) {
        chat!.textMessege = textMessage;
      });
    }

    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: DateTime.now().toIso8601String(),
      text: message.text,
    );

    setState(() {
      _messages.insert(0, textMessage);
    });

    fetchData(message.text).then((answer) {
      _answer(answer);
      _isProcessing = false; // Снимаем флаг после получения ответа
      setState(() {}); // Обновляем состояние для перерисовки интерфейса
    }).catchError((error) {
      _isProcessing = false; // Снимаем флаг в случае ошибки
      setState(() {}); // Обновляем состояние для перерисовки интерфейса
      print('Ошибка при отправке сообщения: $error');
    });

  }

  void _answer(String answerText) {
    final textMessage = types.TextMessage(
      author: _user2,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: DateTime.now().toIso8601String(),
      text: answerText,
    );

    setState(() {
      _messages.insert(0, textMessage); // Вставляем ответ от сервера
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.subtitle)),
      body: Stack(
        children: [
          Chat(
            messages: _messages,
            onSendPressed: _question,
            user: _user,
          ),
          if (_isProcessing)  // Correct usage of collection if
            Positioned(
              child: Container(
                alignment: Alignment.center,
                color: Colors.black54,
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}


Future<ChatModel> firstMessage(String theme) async {
  var url = Uri.parse('http://$baseIP/api/v1/chat-assistant/new-chat');
  var params = {
    'theme': theme,
    'user_id': '1'
  };

  try {
    var response = await http.post(
      url,
      body: params,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponseChat = jsonDecode(response.body);

      print('Ответ сервера: $jsonResponseChat');
      var chatModel = ChatModel(jsonResponseChat["chat-id"], jsonResponseChat["message"]);
      return chatModel;
    } else {
      return ChatModel(0, 'Ошибка: ${response.statusCode}');
    }
  } catch (e) {
    return ChatModel(0, 'Ошибка при выполнении запроса: $e');
  }
}

Future<String> fetchData(String newMessageText) async {
  final response = await http.get(Uri.http(baseIP, '/api/v1/chat-assistant/get-response', {
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
