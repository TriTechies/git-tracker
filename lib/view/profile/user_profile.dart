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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          color: isDarkMode 
              ? Colors.grey[800] 
              : const Color.fromARGB(255, 234, 236, 240),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              color: isDarkMode ? Colors.grey[700] : Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            dividerHeight: 0,
            labelColor: Colors.blue[400],
            unselectedLabelColor: isDarkMode ? Colors.grey[400] : Colors.grey[800],
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      color: isDarkMode ? Colors.grey[850] : Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Showing last month activity',
              style: TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      color: isDarkMode ? Colors.grey[850] : Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '2 achievements',
              style: TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: Card(
        elevation: 2,
        color: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title, 
                      style: TextStyle(
                        fontSize: 14, 
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle, 
                      style: TextStyle(
                        fontSize: 12, 
                        color: isDarkMode ? Colors.grey[400] : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Theme.of(context).appBarTheme.backgroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Your Profile',
                      style: TextStyle(
                        fontSize: 24, 
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.titleLarge?.color,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.settings, 
                        size: 28,
                        color: Theme.of(context).iconTheme.color,
                      ),
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
                      children: [
                        Text(
                          'safeer ep',
                          style: TextStyle(
                            fontSize: 20, 
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.titleLarge?.color,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Engineer',
                          style: TextStyle(
                            fontSize: 16, 
                            color: isDarkMode ? Colors.grey[400] : Colors.grey,
                          ),
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
        backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
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
        unselectedItemColor: isDarkMode ? Colors.grey[400] : Colors.grey,
      ),
    );
  }
}
