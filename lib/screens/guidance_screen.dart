import 'package:flutter/material.dart';

class GuidanceScreen extends StatelessWidget {
  const GuidanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final guidanceItems = [
      _GuidanceItem(
        icon: Icons.restaurant,
        title: 'Diabetes Management',
        description: 'Blood sugar control through diet and lifestyle.',
        color: Colors.green,
        tips: [
          'Choose whole grains over refined carbs',
          'Include lean proteins in every meal',
          'Eat plenty of non-starchy vegetables',
          'Limit sugary drinks and snacks',
        ],
        foods: [
          'Quinoa with grilled chicken and vegetables',
          'Greek yogurt with berries and nuts',
          'Salmon with sweet potato and broccoli',
          'Oatmeal with almond butter and banana',
        ],
      ),
      _GuidanceItem(
        icon: Icons.favorite,
        title: 'Cardiovascular Health',
        description: 'Heart disease and stroke prevention.',
        color: Colors.red,
        tips: [
          'Reduce sodium intake to <2,300mg daily',
          'Include omega-3 rich foods',
          'Limit saturated and trans fats',
          'Monitor blood pressure regularly',
        ],
        foods: [
          'Salmon with avocado and spinach salad',
          'Walnuts and almonds as snacks',
          'Oatmeal with flaxseeds and berries',
          'Grilled fish with olive oil and herbs',
        ],
      ),
      _GuidanceItem(
        icon: Icons.air,
        title: 'Respiratory Health',
        description: 'Asthma and COPD management.',
        color: Colors.blue,
        tips: [
          'Avoid triggers like smoke and pollution',
          'Practice breathing exercises',
          'Stay hydrated to thin mucus',
          'Use air purifiers at home',
        ],
        foods: [
          'Green tea with honey and lemon',
          'Ginger and turmeric smoothies',
          'Steamed vegetables with garlic',
          'Warm soups with anti-inflammatory spices',
        ],
      ),
      _GuidanceItem(
        icon: Icons.fitness_center,
        title: 'Exercise Guidelines',
        description: 'Safe physical activity for chronic conditions.',
        color: Colors.orange,
        tips: [
          'Start with 10-minute walks daily',
          'Gradually increase to 30 minutes',
          'Include strength training 2x/week',
          'Monitor symptoms during exercise',
        ],
        foods: [
          'Banana with peanut butter pre-workout',
          'Greek yogurt post-workout',
          'Hydrating fruits like watermelon',
          'Protein smoothies for recovery',
        ],
      ),
      _GuidanceItem(
        icon: Icons.water_drop,
        title: 'Hydration & Wellness',
        description: 'Proper hydration for overall health.',
        color: Colors.cyan,
        tips: [
          'Drink water before meals',
          'Carry a water bottle',
          'Set hourly reminders',
          'Monitor urine color for hydration',
        ],
        foods: [
          'Cucumber and mint infused water',
          'Coconut water for electrolytes',
          'Herbal teas (chamomile, ginger)',
          'Water-rich fruits like melons',
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
                          const SizedBox(height: 16),
                          Text(
                            'Healthy Food Examples:',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: item.color,
                                ),
                          ),
                          const SizedBox(height: 8),
                          ...item.foods.map((food) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.restaurant,
                                      size: 16,
                                      color: item.color,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        food,
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              fontStyle: FontStyle.italic,
                                            ),
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
  final List<String> foods;

  const _GuidanceItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.tips,
    required this.foods,
  });
}


