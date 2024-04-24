import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:english_hakaton/route/route.gr.dart';
import 'package:flutter/material.dart';

import '../../../../theme/main_theme.dart';

@RoutePage()
class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: mainColor,
              leading: Container(), // Remove the default leading icon button
              flexibleSpace: Container(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () {
                        context.router.replace(GeneralRoute());// Handle back button press
                      },
                    ),
                    const SizedBox(width: 8), // Adjust the width as needed
                    const Text(
                      'Налаштування',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.only(top: 20), // Add padding above SliverList
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  ListTile(
                    title: Text(
                      'Налаштування Профілю',
                      style: settingsSubElementsTextStyle,
                    ),
                  ),
                  ListTile(
                    leading: const CircleAvatar(
                      child: Text('DN'),
                    ),
                    title: Text(
                      'David Negr',
                      style: settingsElementsTextStyle,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      context.router.replace(AccountSettingsRoute());// Handle account tap
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Загальні Налаштування',
                      style: settingsSubElementsTextStyle,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.language),
                    title: Text(
                      'Мова',
                      style: settingsElementsTextStyle,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  SwitchListTile(
                    secondary: const Icon(Icons.notifications),
                    title: Text(
                      'Сповіщення',
                      style: settingsElementsTextStyle,
                    ),
                    value: true, // Set the initial value
                    onChanged: (bool value) {
                       value = false;// Handle notifications toggle
                    },
                  ),
                  SwitchListTile(
                    secondary: const Icon(Icons.assistant),
                    title: Text(
                      'Асистент',
                      style: settingsElementsTextStyle,
                    ),
                    value: true, // Set the initial value
                    onChanged: (bool value) {
                      value=false;// Handle assistant toggle
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.help),
                    title: Text(
                      'Підтримка',
                      style: settingsElementsTextStyle,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                  ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title: Text(
                      'Вийти з профілю',
                      style: settingsElementsTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}