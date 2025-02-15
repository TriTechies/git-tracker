import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:git_tracker/view/settings/settings.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildCustomTabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 234, 236, 240),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            dividerHeight: 0,
            labelColor: Colors.blue[400],
            unselectedLabelColor: Colors.grey[800],
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            tabs: const [
              Tab(text: 'Activity'),
              Tab(text: 'Achievements'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivitySection() {
    return Container(
      color: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Showing last month activity',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded( 
              child: ListView(
                children: [
                  _buildActivityItemWithPadding('112 points earned!', 'Today, 12:34 PM', Icons.arrow_upward, Colors.green),
                  _buildActivityItemWithPadding('62 points earned!', 'Today, 07:12 AM', Icons.arrow_upward, Colors.green),
                  _buildActivityItemWithPadding('Challenge completed!', 'Yesterday, 14:12 PM', Icons.emoji_events, Colors.orange),
                  _buildActivityItemWithPadding('Weekly winning streak is broken!', '12 Jun, 16:14 PM', Icons.arrow_downward, Colors.red),
                  _buildActivityItemWithPadding('96 points earned!', '11 Jun, 17:45 PM', Icons.arrow_upward, Colors.green),
                  _buildActivityItemWithPadding('110 points earned!', '10 Jun, 18:32 PM', Icons.arrow_upward, Colors.green),
                  _buildActivityItemWithPadding('110 points earned!', '10 Jun, 18:32 PM', Icons.arrow_upward, Colors.green),
                  _buildActivityItemWithPadding('110 points earned!', '10 Jun, 18:32 PM', Icons.arrow_upward, Colors.green),
                  _buildActivityItemWithPadding('110 points earned!', '10 Jun, 18:32 PM', Icons.arrow_upward, Colors.green),
                  _buildActivityItemWithPadding('110 points earned!', '10 Jun, 18:32 PM', Icons.arrow_upward, Colors.green),
                  _buildActivityItemWithPadding('110 points earned!', '10 Jun, 18:32 PM', Icons.arrow_upward, Colors.green),
                  _buildActivityItemWithPadding('110 points earned!', '10 Jun, 18:32 PM', Icons.arrow_upward, Colors.green),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementsSection() {
    return Container(
      color: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '2 achievements',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildActivityItemWithPadding('Best Runner', '1 month ago', Icons.emoji_events, Colors.orange),
                  _buildActivityItemWithPadding('Best of the month!', '2 days ago', Icons.emoji_events, Colors.orange),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItemWithPadding(String title, String subtitle, IconData icon, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 40,
                child: Icon(icon, color: iconColor, size: 30),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Your Profile',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.settings, size: 28),
                      onPressed: () {
                        Get.to(const Settings());
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                        'https://safeerep.vercel.app/_next/image?url=%2F_next%2Fstatic%2Fmedia%2Fprofile.856bb6b3.jpg&w=3840&q=75',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
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
                _buildCustomTabBar(),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildActivitySection(),
                _buildAchievementsSection(),
              ],
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
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey, 
      ),
    );
  }
}
