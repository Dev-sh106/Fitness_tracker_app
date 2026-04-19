import 'package:flutter/material.dart';
import '../models/activity.dart';
import '../widgets/activity_card.dart';

class ActivityTrackerScreen extends StatefulWidget {
  const ActivityTrackerScreen({Key? key}) : super(key: key);

  @override
  State<ActivityTrackerScreen> createState() => _ActivityTrackerScreenState();
}

class _ActivityTrackerScreenState extends State<ActivityTrackerScreen> {
  final List<Activity> _activities = [
    Activity(id: '1', name: 'Running', durationMinutes: 30),
    Activity(id: '2', name: 'Walking', durationMinutes: 45),
    Activity(id: '3', name: 'Cycling', durationMinutes: 60),
  ];

  void _toggleActivity(String id) {
    setState(() {
      final index = _activities.indexWhere((activity) => activity.id == id);
      if (index >= 0) {
        _activities[index].isCompleted = !_activities[index].isCompleted;
      }
    });
  }

  void _showAddActivityDialog() {
    final nameController = TextEditingController();
    final durationController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Activity'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Activity Name'),
              ),
              TextField(
                controller: durationController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Duration (minutes)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text;
                final durationStr = durationController.text;
                final duration = int.tryParse(durationStr);

                if (name.isNotEmpty && duration != null && duration > 0) {
                  setState(() {
                    _activities.add(
                      Activity(
                        id: DateTime.now().toString(),
                        name: name,
                        durationMinutes: duration,
                      ),
                    );
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _activities.isEmpty
          ? const Center(child: Text('No activities yet. Add some!'))
          : ListView.builder(
              padding: const EdgeInsets.only(top: 16, bottom: 80),
              itemCount: _activities.length,
              itemBuilder: (context, index) {
                final activity = _activities[index];
                return ActivityCard(
                  activity: activity,
                  onTap: () => _toggleActivity(activity.id),
                );
              },
            ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: FloatingActionButton(
          onPressed: _showAddActivityDialog,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
