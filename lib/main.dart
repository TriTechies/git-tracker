import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:git_tracker/view/dashboard/dashboard_screen.dart';
import 'package:git_tracker/view/home/home_page.dart';
import 'package:git_tracker/view/landing/intro.dart';
import 'package:git_tracker/view/landing/splash_page.dart';
import 'package:git_tracker/view/profile/user_profile.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      getPages: [
        GetPage(
          page: () => const SplashPage(),
          name: '/splash',
        ),
        GetPage(
          name: '/home',
          page: () => const HomePage(),
        ),
        GetPage(
          name: '/profile',
          page: () => const Profile(),
        ),
        GetPage(
          name: '/intro',
          page: () => const Intro(),
        ),
        GetPage(
          name: '/dashboard',
          page: () => const DashboardScreen(),
        )
      ],
    );
  }
}
