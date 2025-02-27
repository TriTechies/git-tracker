import 'package:flutter/material.dart';
import 'package:git_tracker/db/helpers/habit_db_helper.dart';
import 'package:git_tracker/view/dashboard/widgets/contribution_chart_widget.dart';
import 'package:git_tracker/view/dashboard/widgets/habit_graph.dart';
import 'package:git_tracker/view/dashboard/widgets/status_widget.dart';
import 'package:git_tracker/view/add_habit/add_habit_screen.dart';
import 'package:git_tracker/view/profile/profile_screen.dart';
import 'package:git_tracker/model/habit.dart';
import 'package:get/get.dart';
import 'package:git_tracker/controller/habit_controller.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabController;
  final habitController = Get.find<HabitController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    habitController.loadHabits();
  }

  void _onItemTapped(int index) {
    if (index == 1) {
      // Navigate to Add Habit Screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AddHabitScreen()),
      );
      return;
    } else if (index == 2) {
      // Navigate to Profile Screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
      return;
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Habit',
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Welcome, User!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          const StatusWidget(),
          const SizedBox(height: 20),
          const HabitGraph(),
          const SizedBox(height: 20),
          // Your Habits section with Delete All button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Your Habits',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              TextButton.icon(
                onPressed: () => _showDeleteConfirmationDialog(),
                icon: const Icon(Icons.delete, color: Colors.red),
                label: const Text('Delete All',
                    style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Obx(() {
            final habits = habitController.habits;
            if (habits.isEmpty) {
              return const Center(
                child: Text('No habits yet. Create one!'),
              );
            }
            return FutureBuilder<List<Habit>>(
              future: HabitDbHelper.instance
                  .getAllHabits(), // Replace with your actual database call
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No habits added yet');
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final habit = snapshot.data![index];
                    return ContributionChartWidget(habit: habit);
                  },
                );
              },
            );
          }),
        ],
      ),
    );
  }

  // Add this new method to show confirmation dialog
  Future<void> _showDeleteConfirmationDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete All Habits'),
          content: const Text(
              'Are you sure you want to delete all habits? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await HabitDbHelper.instance.deleteAllHabits();
                Navigator.of(context).pop();
                setState(() {}); // Refresh the UI
              },
              child:
                  const Text('Delete All', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
