import 'package:flutter/material.dart';
import '../models/tip.dart';
import '../widgets/tip_card.dart';

class TipsScreen extends StatelessWidget {
  TipsScreen({Key? key}) : super(key: key);

  final List<Tip> _tips = [
    Tip(
      id: '1',
      title: 'Stay Hydrated',
      description: 'Drink at least 8 glasses of water a day. Hydration is crucial for maintaining energy levels and ensuring your body functions optimally during workouts.',
      iconData: Icons.water_drop,
    ),
    Tip(
      id: '2',
      title: 'Consistent Sleep',
      description: 'Aim for 7-9 hours of sleep per night. Sleep is when your body repairs itself, builds muscle, and recovers from the day\'s physical stress.',
      iconData: Icons.bedtime,
    ),
    Tip(
      id: '3',
      title: 'Warm Up',
      description: 'Always warm up before exercising to prevent injuries. Dynamic stretching prepares your muscles and cardiovascular system for the workout ahead.',
      iconData: Icons.directions_run,
    ),
    Tip(
      id: '4',
      title: 'Balanced Diet',
      description: 'Incorporate proteins, carbs, and healthy fats in your meals. Proper nutrition provides the fuel your body needs to perform and recover.',
      iconData: Icons.restaurant,
    ),
    Tip(
      id: '5',
      title: 'Rest Days',
      description: 'Take rest days to allow your muscles to recover and grow. Overtraining can lead to burnout and increase the risk of injury.',
      iconData: Icons.weekend,
    ),
    Tip(
      id: '6',
      title: 'Track Progress',
      description: 'Keep a log of your workouts and diet to stay motivated. Seeing how far you\'ve come can push you to achieve your fitness goals.',
      iconData: Icons.trending_up,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.85,
        ),
        itemCount: _tips.length,
        itemBuilder: (context, index) {
          final tip = _tips[index];
          return TipCard(
            tip: tip,
            onTap: () {
              Navigator.pushNamed(
                context,
                '/tip_detail',
                arguments: tip,
              );
            },
          );
        },
      ),
    );
  }
}
