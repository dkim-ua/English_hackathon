import 'package:english_hakaton/theme/main_theme.dart';
import 'package:flutter/material.dart';

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({Key? key}) : super(key: key);

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  final TextEditingController _nameController = TextEditingController(text: 'Lera Mais');
  final TextEditingController _emailController = TextEditingController(text: 'mva9727@gmail.com');
  int _age = 19;
  String _selectedGender = 'male'; // initial selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor, // Use the theme color
        title: const Text('Personal info',style: TextStyle(color: Colors.white),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,color: Colors.white,),
          onPressed: () {
            Navigator.of(context).pop(); // Go back on press
          },
        ),
      ),
      body: SingleChildScrollView( // Make it scrollable
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60, // Size of the circle
              backgroundColor: mainColor, // Placeholder color
              child: IconButton(
                icon: const Icon(
                  Icons.camera_alt,
                  size: 60,
                  color: Colors.white,
                ),
                onPressed: () {
                  // TODO: Implement image upload functionality
                },
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // TODO: Implement image upload functionality
              },
              child: Text('Upload Image',style: TextStyle(color: mainColor),),
            ),
            const Divider(),
            _buildTextField(label: "Name", controller: _nameController),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildGenderChoice('male', 'Male'),
                _buildGenderChoice('female', 'Female'),
              ],
            ),
            const Divider(),
            _buildTextField(
              label: "Age",
              controller: TextEditingController(text: _age.toString()), // Display current age
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _age = int.tryParse(value) ?? _age; // Update age
                });
              },
            ),
            const Divider(),
            _buildTextField(label: "Email", controller: _emailController),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    void Function(String)? onChanged,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      onChanged: onChanged,
    );
  }

  Widget _buildGenderChoice(String value, String text) {
    return Expanded(
      child: ListTile(
        title: Text(text),
        leading: Radio<String>(
          value: value,
          groupValue: _selectedGender,
          onChanged: (String? newValue) {
            setState(() {
              _selectedGender = newValue!;
            });
          },
          activeColor: mainColor,
        ),
      ),
    );
  }
}
