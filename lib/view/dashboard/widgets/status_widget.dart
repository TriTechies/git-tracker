import 'package:flutter/material.dart';

class StatusWidget extends StatefulWidget {
  const StatusWidget({super.key});

  @override
  _StatusWidgetState createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(
                            255, 243, 244, 246), // Background color
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.info_outline,
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
                          'Summery',
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color.fromARGB(
                        255, 243, 244, 246), // Background color
                  ),
                  child: IconButton(
                    icon: Icon(
                      _isExpanded ? Icons.chevron_left : Icons.chevron_right,
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
            if (_isExpanded) // Show the content when expanded
              const Text('Everything is running smoothly!'),
          ],
        ),
      ),
    );
  }
}
