import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:git_tracker/controller/text_controller.dart';
import 'package:git_tracker/controller/theme_controller.dart';
import 'package:git_tracker/view/dashboard/dashboard_screen.dart';
import 'package:git_tracker/view/home/home_page.dart';
import 'package:git_tracker/view/landing/intro.dart';
import 'package:git_tracker/view/landing/splash_page.dart';
import 'package:git_tracker/view/login/login_page.dart';
import 'package:git_tracker/view/profile/user_profile.dart';
import 'package:git_tracker/view/settings/settings.dart';
import 'package:git_tracker/view/signUp/gender_page.dart';
import 'package:git_tracker/view/signUp/habits_options.dart';
import 'package:git_tracker/view/signUp/sign_up.dart';
import 'package:git_tracker/view/signUp/sign_up_continue.dart';
import 'package:git_tracker/db/database_helper.dart';
import 'view/passwordReset/password_reset.dart';
import 'package:git_tracker/controller/habits_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().database;
  await GetStorage.init();
  
  // initialize controllers
  Get.put(TextController());
  Get.put(DatabaseHelper());
  Get.put(HabitController());
  
  // add the theme controller
  Get.put(ThemeController()); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Get theme controller to observe changes
    final themeController = Get.find<ThemeController>();
    
    return Obx(() => GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // Apply theme configuration
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        cardColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        iconTheme: const IconThemeData(
          color: Colors.black87,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[900],
        cardColor: Colors.grey[850],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[850],
          elevation: 0,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white70,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.grey[850],
        ),
      ),
      themeMode: themeController.isDarkMode ? ThemeMode.dark : ThemeMode.light,
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
          name: '/settings',
          page: () => const Settings(),
        ),
        GetPage(
          name: '/intro',
          page: () => const Intro(),
        ),
        GetPage(
          name: '/login',
          page: () => const LoginPage(),
        ),
        GetPage(
          name: '/signup',
          page: () => const SignUp(),
        ),
        GetPage(
          name: '/gender',
          page: () => const GenderPage(),
        ),
        GetPage(
          name: '/options',
          page: () => const HabitsOptions(),
        ),
        GetPage(
          name: '/signupcontinue',
          page: () => const SignUpContinue(),
        ),
        GetPage(
          name: '/forgotpassword',
          page: () => const ForgotPassword(),
        ),
        GetPage(
          name: '/dashboard',
          page: () => const DashboardScreen(),
        )
      ],
    ));
  }
}
