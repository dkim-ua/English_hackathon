import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:english_hakaton/pages/general/home_page.dart';
import 'package:english_hakaton/pages/general/chat/person_of_chat_page.dart';
import 'package:english_hakaton/pages/general/profile/profile_page.dart';
import 'package:english_hakaton/pages/general/training/training_page.dart';
import 'package:english_hakaton/pages/general/vocabulary/vocabulary_page.dart';
import 'package:english_hakaton/route/route.gr.dart';
import 'package:flutter/material.dart';

@RoutePage()
class GeneralPage extends StatefulWidget {
  const GeneralPage({super.key});

  @override
  State<GeneralPage> createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        backgroundColor: Colors.white,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Головна',
          ),
          NavigationDestination(
            icon: Icon(Icons.model_training_rounded),
            label: 'Тренуватися',
          ),
          NavigationDestination(
            icon: Icon(Icons.mark_chat_unread_outlined),
            label: 'Чат',
          ),
          NavigationDestination(
            icon: Icon(Icons.book),
            label: 'Словник',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Профіль',
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
                  onPressed: () {context.router.push(const SettingsRoute());},
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
    );
  }
}