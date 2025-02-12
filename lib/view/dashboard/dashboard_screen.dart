import 'package:flutter/material.dart';
import 'package:git_tracker/view/dashboard/widgets/contribution_chart_widget.dart';
import 'package:git_tracker/view/dashboard/widgets/habit_graph.dart';
import 'package:git_tracker/view/dashboard/widgets/status_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Activity',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40), // Adjusted height
          child: _buildCustomTabBar(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildDashboardContent(),
          buildDashboardContent(),
          buildDashboardContent(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  /// Custom TabBar with smaller size
  Widget _buildCustomTabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 16, vertical: 4), // Reduced padding
      child: Container(
        height: 36, // Reduced height
        decoration: BoxDecoration(
          color: const Color.fromARGB(
              255, 234, 236, 240), // Gray background for tab bar
          borderRadius:
              BorderRadius.circular(16), // Slightly smaller border radius
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              color: Colors.white, // White background for selected tab
              borderRadius: BorderRadius.circular(16),
            ),
            dividerHeight: 0,
            labelColor: Colors.blue[400], // Selected tab text color
            unselectedLabelColor: Colors.grey[800], // Unselected tab text color
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: const TextStyle(
                fontWeight: FontWeight.bold), // Smaller font size
            tabs: const [
              Tab(text: 'Daily'),
              Tab(text: 'Weekly'),
              Tab(text: 'Monthly'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDashboardContent() {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Welcome, User!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          StatusWidget(),
          SizedBox(height: 20),
          HabitGraph(),
          SizedBox(height: 20),
          ContributionChartWidget(),
        ],
      ),
    );
  }
}
