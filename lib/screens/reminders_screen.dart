import 'package:flutter/material.dart';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  bool _medicationReminders = true;
  bool _hydrationReminders = true;
  bool _exerciseReminders = false;
  bool _appointmentReminders = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminders'),
        backgroundColor: Colors.purple.shade50,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.purple.shade50,
              Colors.white,
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.medication, color: Colors.blue.shade600),
                        const SizedBox(width: 12),
                        Text(
                          'Medication Reminders',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text('Get notified when it\'s time to take your medications'),
                    const SizedBox(height: 12),
                    SwitchListTile(
                      value: _medicationReminders,
                      onChanged: (value) => setState(() => _medicationReminders = value),
                      title: const Text('Enable Medication Alerts'),
                      subtitle: const Text('8:00 AM, 2:00 PM, 8:00 PM'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.water_drop, color: Colors.cyan.shade600),
                        const SizedBox(width: 12),
                        Text(
                          'Hydration Reminders',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text('Stay hydrated throughout the day'),
                    const SizedBox(height: 12),
                    SwitchListTile(
                      value: _hydrationReminders,
                      onChanged: (value) => setState(() => _hydrationReminders = value),
                      title: const Text('Enable Hydration Alerts'),
                      subtitle: const Text('Every 2 hours from 8 AM to 8 PM'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.fitness_center, color: Colors.orange.shade600),
                        const SizedBox(width: 12),
                        Text(
                          'Exercise Reminders',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text('Stay active with regular exercise'),
                    const SizedBox(height: 12),
                    SwitchListTile(
                      value: _exerciseReminders,
                      onChanged: (value) => setState(() => _exerciseReminders = value),
                      title: const Text('Enable Exercise Alerts'),
                      subtitle: const Text('Daily at 6:00 PM'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              color: Colors.red.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_today, color: Colors.red.shade600),
                        const SizedBox(width: 12),
                        Text(
                          'Appointment Reminders',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.red.shade700,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text('Never miss your important doctor appointments'),
                    const SizedBox(height: 12),
                    SwitchListTile(
                      value: _appointmentReminders,
                      onChanged: (value) => setState(() => _appointmentReminders = value),
                      title: const Text('Enable Appointment Alerts'),
                      subtitle: const Text('24 hours and 2 hours before'),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Next Appointment:',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red.shade700,
                                ),
                          ),
                          const SizedBox(height: 4),
                          const Text('Dr. Smith - Cardiology'),
                          const Text('Tomorrow at 2:00 PM'),
                          const Text('Location: City Medical Center'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


