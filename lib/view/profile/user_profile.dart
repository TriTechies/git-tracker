import 'package:flutter/material.dart';
class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your Profile',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.settings, size: 28),
                  onPressed: () {
                    print('Settings button clicked');
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
          const   Row(
              children: [
                 CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    'https://safeerep.vercel.app/_next/image?url=%2F_next%2Fstatic%2Fmedia%2Fprofile.856bb6b3.jpg&w=3840&q=75',
                  ),
                ),
                 SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text(
                      'safeer ep',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Engineer',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}