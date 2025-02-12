import 'package:flutter/material.dart';

class StatusWidget extends StatefulWidget {
  const StatusWidget({super.key});

  @override
  _StatusWidgetState createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded; // Toggle accordion state
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Background color
          border: Border.all(
              color: const Color.fromARGB(255, 243, 244, 246),
              width: 1), // Border
          borderRadius: BorderRadius.circular(20), // Rounded corners
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(
                              255, 243, 244, 246), // Background color
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.trending_up_sharp,
                          ),
                        ),
                      ), // Icon next to title
                      const SizedBox(width: 8),
                      const Column(
                        children: [
                          Text(
                            'All Habits',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Summary',
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: const Color.fromARGB(255, 243, 244, 246),
                          width: 1),
                    ),
                    child: IconButton(
                      icon: Transform.rotate(
                        angle: _isExpanded
                            ? -3.14159 / 2
                            : 3.14159 / 2, // Rotate 90 degrees when collapsed
                        child: const Icon(
                          Icons.chevron_right,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _isExpanded = !_isExpanded; // Toggle accordion state
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (_isExpanded) // Show the expanded content
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Everything is running smoothly!'),
                    SizedBox(height: 10),
                    Text('Success Rate: 95%'),
                    Text('Completed: 120'),
                    Text('Points Earned: 300'),
                    Text('Best Streak Day: 10'),
                    Text('Skipped: 5'),
                    Text('Failed: 2'),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
