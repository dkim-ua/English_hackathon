import 'package:auto_route/annotations.dart';
import 'package:english_hakaton/pages/general/home_page.dart';
import 'package:english_hakaton/pages/general/chat/person_of_chat_page.dart';
import 'package:english_hakaton/pages/general/profile/profile_page.dart';
import 'package:english_hakaton/pages/general/vocabulary/vocabulary_page.dart';
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
        Container(),
        /// Chat page
        const PersonOfChat(),
        /// Vocabulary page
        VocabularyPage(),
        ///Profile page
        ListView(
          children: <Widget>[
            AppBar(
              title: const Text('DAVID NEGR'),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {

                  },
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