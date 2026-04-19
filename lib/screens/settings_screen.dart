import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Push Notifications'),
            value: true,
            onChanged: (bool value) {},
          ),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: false,
            onChanged: (bool value) {},
          ),
          ListTile(
            title: const Text('Units'),
            subtitle: const Text('Metric (kg, cm)'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
