import 'package:flutter/material.dart';
import '../models/tip.dart';

class TipDetailScreen extends StatelessWidget {
  const TipDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Extract the tip from the route arguments
    final tip = ModalRoute.of(context)!.settings.arguments as Tip;

    return Scaffold(
      appBar: AppBar(
        title: Text(tip.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            Hero(
              tag: 'tip_icon_${tip.id}',
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                child: Icon(
                  tip.iconData,
                  size: 64,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              tip.title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                tip.description,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.6,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
