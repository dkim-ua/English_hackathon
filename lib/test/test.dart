import 'dart:convert';
import 'package:english_hakaton/enums/enum_chat.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  var url = Uri.parse('http://172.20.10.3:7050/api/v1/chat-assistant/new-chat');
  var params = {
    'theme': ChatType.hospital.serverType(),
    'user_id': '1'
  };

  try {
    var response = await http.post(
      url,
      body: params,
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print('Ответ сервера: $jsonResponse');
    } else {
      print('Ошибка: ${response.statusCode}');
    }
  } catch (e) {
    print('Ошибка при выполнении запроса: $e');
  }

  fetchData();
}

Future<void> fetchData() async {
  final response = await http.get(Uri.http('192.168.81.27:7050', '/api/v1/chat-assistant/get-response', {
    'chat-id': '2', // Replace with your chatId
    'class-id': '1', // Replace with your userId
    'new-message-text': 'How to print Hello World in Java', // Replace with your message text
  }));

  try {
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print('Response from server: $jsonResponse');
    } else {
      print('Error: ${response.statusCode}');
    }
  } catch (e) {
    print('Error during the request: $e');
  }
}
