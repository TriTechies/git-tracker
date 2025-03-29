import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:git_tracker/view/profile/user_profile.dart';
import 'package:git_tracker/controller/theme_controller.dart';
import 'package:git_tracker/view/settings/general_settings_page.dart';
import 'package:git_tracker/view/settings/security_page.dart';
import 'package:git_tracker/view/settings/notifications_page.dart';
import 'package:git_tracker/view/settings/rate_us_page.dart';
import 'package:git_tracker/view/settings/share_page.dart';
import 'package:git_tracker/view/settings/about_us_page.dart';
import 'package:git_tracker/view/settings/support_page.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final ThemeController _themeController = Get.find<ThemeController>();
  late Map<String, bool> _toggleStates;

  @override
  void initState() {
    super.initState();
    _toggleStates = {
      'Dark Mode': _themeController.isDarkMode,
      'Sounds': true,
      'Vacation Mode': false,
    };
  }

  Widget _buildActivitySection(String sectionHead) {
    final List<(String, IconData, bool)> items = sectionHead == 'GENERAL'
        // the third value is used to show the toggle button or not;
        ? [
            ('General', Icons.settings, false),
            ('Dark Mode', Icons.dark_mode, true),
            ('Security', Icons.security, false),
            ('Notifications', Icons.notifications, false),
            ('Sounds', Icons.volume_up, true),
            ('Vacation Mode', Icons.beach_access, true),
          ]
        : [
            ('Rate Us', Icons.star, false),
            ('Share', Icons.share, false),
            ('About Us', Icons.info, false),
            ('Support', Icons.help, false),
          ];

    return Container(
      color: Theme.of(context).brightness == Brightness.dark 
          ? Colors.grey[850] 
          : Colors.grey[100],
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              sectionHead, 
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).brightness == Brightness.dark 
                    ? Colors.grey[400] 
                    : Colors.grey,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
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
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                indent: 16,
                endIndent: 16,
                color: Theme.of(context).dividerColor,
              ),
              itemBuilder: (context, index) {
                final item = items[index];
                final String title = item.$1;
                final IconData icon = item.$2;
                final bool showToggle = item.$3;

                return SizedBox(
                  height: 80,
                  child: _buildSettingsItem(
                    title,
                    icon,
                    showToggle: showToggle,
                    switchValue: _toggleStates[title] ?? false,
                    onSwitchChanged: (value) {
                      setState(() {
                        _toggleStates[title] = value;
                        
                        // Handle dark mode toggle specifically
                        if (title == 'Dark Mode') {
                          _themeController.toggleTheme(value);
                        }
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(
    String title,
    IconData icon, {
    bool showToggle = false,
    bool switchValue = false,
    ValueChanged<bool>? onSwitchChanged,
  }) {
    return Material(
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: showToggle
            ? null
            : () {
                switch (title) {
                  case 'General':
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const GeneralSettings()));
                    break;
                  case 'Security':
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const SecurityPage()));
                    break;
                  case 'Notifications':
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsPage()));
                    break;
                  case 'Rate Us':
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const RateUsPage()));
                    break;
                  case 'Share':
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const SharePage()));
                    break;
                  case 'About Us':
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutUsPage()));
                    break;
                  case 'Support':
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const SupportPage()));
                    break;
                  default:
                    print('$title tapped');
                }
              },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(
                icon,
                size: 24,
                color: Theme.of(context).iconTheme.color,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ),
              if (showToggle)
                Switch(
                  value: switchValue,
                  onChanged: onSwitchChanged,
                  activeTrackColor: Colors.green,
                  activeColor: Colors.white,
                )
              else
                Icon(
                  Icons.chevron_right,
                  size: 24,
                  color: Theme.of(context).iconTheme.color?.withOpacity(0.6),
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
            color: Theme.of(context).appBarTheme.backgroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.chevron_left, 
                        size: 32,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      onPressed: () {
                        Get.to(const Profile());
                      },
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 24, 
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.titleLarge?.color,
                      ),
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
        backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: 'Events'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Theme.of(context).brightness == Brightness.dark 
            ? Colors.grey[400] 
            : Colors.grey,
      ),
    );
  }
}