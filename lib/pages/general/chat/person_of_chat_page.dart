import 'package:auto_route/auto_route.dart';
import 'package:english_hakaton/enums/enum_chat.dart';
import 'package:english_hakaton/route/route.gr.dart';
import 'package:english_hakaton/theme/main_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PersonOfChatPage extends StatefulWidget {
  const PersonOfChatPage({super.key});

  @override
  State<PersonOfChatPage> createState() => _PersonOfChatPageState();
}

class _PersonOfChatPageState extends State<PersonOfChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        title: const Text('Теми для чату'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 12.0), // Add padding only at the bottom
        child: ListView(
          children: <Widget>[
            _buildChatThemeTile('Лікарня', 'Лікар', ChatType.hospital.serverType()),
            _buildChatThemeTile('Таксі', 'Водій', ChatType.taxi.serverType()),
            _buildChatThemeTile('Ресторан', 'Офіціант', ChatType.restaurant.serverType()),
            _buildChatThemeTile('Співбесіда', 'Рекрутер', ChatType.interview.serverType()),
            _buildChatThemeTile('Готель', 'Менеджер', ChatType.hotel.serverType()),
            _buildChatThemeTile('Побачення', 'Подруга', ChatType.friend.serverType()),
          ],
        ),
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