import 'package:flutter/material.dart';

class GuidanceScreen extends StatelessWidget {
  const GuidanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final guidanceItems = [
      _GuidanceItem(
        icon: Icons.restaurant,
        title: 'Diet Plan for Diabetes',
        description: 'Lower carbs, more fiber, balanced meals.',
        color: Colors.green,
        tips: [
          'Choose whole grains over refined carbs',
          'Include lean proteins in every meal',
          'Eat plenty of non-starchy vegetables',
          'Limit sugary drinks and snacks',
        ],
      ),
      _GuidanceItem(
        icon: Icons.fitness_center,
        title: 'Exercise Tips',
        description: '30 min walking, 5x per week. Start gradually.',
        color: Colors.blue,
        tips: [
          'Start with 10-minute walks daily',
          'Gradually increase to 30 minutes',
          'Include strength training 2x/week',
          'Monitor blood sugar before/after exercise',
        ],
      ),
      _GuidanceItem(
        icon: Icons.water_drop,
        title: 'Hydration',
        description: 'Aim for 6–8 glasses of water daily.',
        color: Colors.cyan,
        tips: [
          'Drink water before meals',
          'Carry a water bottle',
          'Set hourly reminders',
          'Monitor urine color for hydration',
        ],
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Personalized Guidance'),
        backgroundColor: Colors.green.shade50,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green.shade50,
              Colors.white,
            ],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: guidanceItems.length,
          itemBuilder: (context, index) {
            final item = guidanceItems[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Card(
                elevation: 4,
                child: ExpansionTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: item.color.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(item.icon, color: item.color),
                  ),
                  title: Text(
                    item.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(item.description),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Key Tips:',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: item.color,
                                ),
                          ),
                          const SizedBox(height: 8),
                          ...item.tips.map((tip) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      size: 16,
                                      color: item.color,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        tip,
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _GuidanceItem {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final List<String> tips;

  const _GuidanceItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.tips,
  });
}


