import 'package:flutter/material.dart';

class RemindersScreen extends StatelessWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reminders')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            value: true,
            onChanged: (_) {},
            title: const Text('Medication Reminders'),
            subtitle: const Text('Smart alerts for meds'),
          ),
          SwitchListTile(
            value: true,
            onChanged: (_) {},
            title: const Text('Hydration Reminders'),
            subtitle: const Text('Drink water regularly'),
          ),
          SwitchListTile(
            value: false,
            onChanged: (_) {},
            title: const Text('Exercise Reminders'),
            subtitle: const Text('Stay active daily'),
          ),
        ],
      ),
    );
  }
}


