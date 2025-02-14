import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:git_tracker/controller/text_controller.dart';
import 'package:git_tracker/view/home/home_page.dart';
import 'package:git_tracker/view/landing/intro.dart';
import 'package:git_tracker/view/landing/splash_page.dart';
import 'package:git_tracker/view/login/login_page.dart';
import 'package:git_tracker/view/profile/user_profile.dart';
import 'package:git_tracker/view/signUp/gender_page.dart';
import 'package:git_tracker/view/signUp/habits_options.dart';
import 'package:git_tracker/view/signUp/sign_up.dart';
import 'package:git_tracker/view/signUp/sign_up_continue.dart';
import 'package:git_tracker/db/database_helper.dart';
// ... existing code ...
// import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void   main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().database;
  runApp(const MyApp());
  Get.put(TextController());
  Get.put(DatabaseHelper());
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
        )
      ],
    );
  }
}
