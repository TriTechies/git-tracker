import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:git_tracker/view/profile/user_profile.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  
  Widget _buildActivitySection(String sectionHead) {
  final List<(String, IconData)> items = sectionHead == 'GENERAL'
      ? [
          ('General', Icons.settings),
          ('Dark Mode', Icons.dark_mode),
          ('Security', Icons.security),
          ('Notifications', Icons.notifications),
          ('Sounds', Icons.volume_up),
          ('Vacation Mode', Icons.beach_access),
        ]
      : [
          ('Rate Us', Icons.star),
          ('Share', Icons.share),
          ('About Us', Icons.info), 
          ('Support', Icons.help), 
        ];

  return Container(
    color: Colors.grey[100], // Background color of the section
    padding: const EdgeInsets.all(24), // Padding for the whole section
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8), // Space below the title
          child: Text(
            sectionHead, // Use the passed section title
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white, // Card-like background
            borderRadius: BorderRadius.circular(12), // Rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                spreadRadius: 2,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ListView.separated(
            shrinkWrap: true, // Prevent unbounded height issues
            physics: const NeverScrollableScrollPhysics(), // Prevents internal scrolling
            itemCount: items.length,
            separatorBuilder: (context, index) => const Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
            ),
            itemBuilder: (context, index) {
              return SizedBox(
                height: 80,
                child: _buildSettingsItem(
                  items[index].$1,
                  items[index].$2,
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}


  Widget _buildSettingsItem(String title, IconData icon) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          // Handle tap
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(
                icon,
                size: 24,
                color: Colors.black,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right,
                size: 24,
                color: Colors.black54,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left, size: 32),
                      onPressed: () {
                        Get.to(const Profile());
                      },
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Settings',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildActivitySection("GENERAL"),
                  _buildActivitySection("ABOUT US"),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
      
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: 'Events'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey, 
      ),
    );
  }
}