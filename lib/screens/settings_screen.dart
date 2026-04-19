import 'package:flutter/material.dart';
import '../main.dart'; // import the global notifier

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (context, currentMode, child) {
          final isDarkMode = currentMode == ThemeMode.dark;

          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            children: [
              SwitchListTile(
                title: const Text('Push Notifications'),
                subtitle: const Text('Stay updated with daily reminders'),
                secondary: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.notifications_active, color: Theme.of(context).colorScheme.primary),
                ),
                value: true,
                onChanged: (bool value) {},
              ),
              const Divider(),
              SwitchListTile(
                title: const Text('Dark Mode'),
                subtitle: const Text('Toggle stunning dark aesthetics'),
                secondary: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isDarkMode ? Icons.dark_mode : Icons.light_mode,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                value: isDarkMode,
                onChanged: (bool value) {
                  themeNotifier.value = value ? ThemeMode.dark : ThemeMode.light;
                },
              ),
              const Divider(),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.straighten, color: Colors.green),
                ),
                title: const Text('Units'),
                subtitle: const Text('Metric (kg, cm)'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
            ],
          );
        },
      ),
    );
  }
}
