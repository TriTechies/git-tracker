import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:git_tracker/view/home/home_page.dart';
import 'package:git_tracker/view/landing/splash_page.dart';

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
        )
      ],
    );
  }
}
