import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:english_hakaton/route/route.gr.dart';
import 'package:english_hakaton/theme/main_theme.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  final TextEditingController _nameController = TextEditingController(text: 'Баклажан');
  final TextEditingController _emailController = TextEditingController(text: 'mva9727@gmail.com');
  int _age = 19;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Text('Профіль',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white), // Added back_ios icon
          onPressed: () => context.router.replace(SettingsRoute()),
        ),
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
                labelText: "Ім'я",
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text('Стать: '),
                Radio<String>(
                  value: 'male',
                  groupValue: null,
                  onChanged: null,
                  activeColor: mainColor,
                ),
                const Text('Чоловіча'),
                Radio<String>(
                  value: 'female',
                  groupValue: null,
                  onChanged: null,
                  activeColor: mainColor,
                ),
                const Text('Жіноча'),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: TextEditingController(text: _age.toString()),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Вік',
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