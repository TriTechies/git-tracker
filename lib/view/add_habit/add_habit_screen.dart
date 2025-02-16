import 'package:flutter/material.dart';
import 'package:git_tracker/view/widgets/chevron_button.dart';
import 'package:git_tracker/view/widgets/my_button.dart';

class AddHabitScreen extends StatelessWidget {
  const AddHabitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: ChevronButton(
            onPressed: () => Navigator.of(context).pop(),
            direction: 'left',
          ),
        ),
        title: const Text('Add Habit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add New Habit',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Habit Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Duration (minutes)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.timer),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            // Icon Selector
            InkWell(
              onTap: () {
                // TODO: Implement icon selection dialog
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.fitness_center), // Default icon
                    SizedBox(width: 8),
                    Text('Select Icon'),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Color Selector
            InkWell(
              onTap: () {
                // TODO: Implement color picker dialog
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.blue, // Default color
                    ),
                    SizedBox(width: 8),
                    Text('Select Color'),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Habit Type
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Habit Type',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'build', child: Text('Build')),
                DropdownMenuItem(value: 'quit', child: Text('Quit')),
              ],
              onChanged: (value) {
                // TODO: Handle habit type selection
              },
            ),
            const SizedBox(height: 16),
            // Goal Frequency
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Frequency',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 3,
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Interval',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'daily', child: Text('Per Day')),
                      DropdownMenuItem(
                          value: 'weekly', child: Text('Per Week')),
                      DropdownMenuItem(
                          value: 'monthly', child: Text('Per Month')),
                    ],
                    onChanged: (value) {
                      // TODO: Handle interval selection
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Reminder Setting
            InkWell(
              onTap: () {
                // TODO: Implement reminder setup dialog
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.notifications),
                    SizedBox(width: 8),
                    Text('Set Reminders'),
                    Spacer(),
                    Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            MyButton(
              name: "Create Habit",
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
