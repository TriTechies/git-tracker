import 'package:flutter/material.dart';
import 'package:git_tracker/view/widgets/chevron_button.dart';

class StatusWidget extends StatefulWidget {
  const StatusWidget({super.key});

  @override
  State<StatusWidget> createState() => _StatusWidgetState();
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
                  ChevronButton(
                    onPressed: () {
                      setState(() {
                        _isExpanded = !_isExpanded; // Toggle accordion state
                      });
                    },
                    direction: _isExpanded ? "up" : "down",
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (_isExpanded) // Show the expanded content
                const Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            child:
                                _InfoTile(title: 'Success Rate', value: '95%')),
                        Expanded(
                            child: _InfoTile(title: 'Completed', value: '120')),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            child: _InfoTile(
                                title: 'Points Earned', value: '300')),
                        Expanded(
                            child: _InfoTile(
                                title: 'Best Streak Day', value: '10')),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            child: _InfoTile(title: 'Skipped', value: '5')),
                        Expanded(child: _InfoTile(title: 'Failed', value: '2')),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String title;
  final String value;

  const _InfoTile({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey, // Gray color for the title
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18, // Larger font size for the value
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
