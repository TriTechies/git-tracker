import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:git_tracker/view/widgets/habit_card.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:git_tracker/view/widgets/my_button.dart';
import '../style/style.dart';
import '../style/colors.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: backgroundColor),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                children: [
                  _buildSlide1(),
                  _buildSlide2(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SmoothPageIndicator(
                controller: _pageController,
                count: 2,
                effect: const ExpandingDotsEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: Colors.white,
                  dotColor: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 40),
              child: MyButton(
                name: "Continue With E-mail",
                color: Colors.white,
                onPressed: () {
                  Get.toNamed('/login');
                },
                textColor: Colors.black,
              ),
            ),
          
          ],
        ),
      ),
    );
  }

  // First Slide
  Widget _buildSlide1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTopSection(),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            "Create \nGood Habits",
            style: defaultstyle(
              fontFamily: "Segoe UI",
              size: 40,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 5),
          child: Text(
            "Change your life by slowly adding new healthy habits \nand sticking to them.",
            style: withoutFontWeight(
              fontFamily: "Segoe UI",
              size: 14,
              color: textColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSlide2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, bottom: 5),
          child: Text(
            'Habits',
            style: defaultstyle(
              fontFamily: "Segoe UI",
              size: 15,
              color: Colors.white,
            ),
          ),
        ),
        const HabitCard(
          heading: "Drink Water",
          image: "habit_water",
          subHeading: "500/2000ML",
          icon: Icons.add,
        ),
        const HabitCard(
          heading: "Walk",
          image: "habit_walk",
          subHeading: "0/10000 STEPS",
          icon: Icons.add,
        ),
        const HabitCard(
          heading: "Meditate",
          image: "habit_meditate",
          subHeading: "30/30 MIN",
          icon: Icons.check,
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
          ),
          child: Text(
            "Track Your Progress",
            style: defaultstyle(
              fontFamily: "Segoe UI",
              size: 40,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 5),
          child: Text(
            "Stay motivated by tracking your progress \nand reaching your goals!",
            style: withoutFontWeight(
              fontFamily: "Segoe UI",
              size: 14,
              color: textColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTopSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                const Positioned(
                  bottom: 20,
                  top: 20,
                  left: 100,
                  child: CircleAvatar(radius: 40),
                ),
                Image.asset('assets/chat popup.png'),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                const Positioned(
                  bottom: 10,
                  top: 20,
                  left: 0,
                  child: CircleAvatar(radius: 40),
                ),
                Image.asset('assets/chat popup.png'),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                const Positioned(
                  bottom: 10,
                  top: 20,
                  left: 100,
                  child: CircleAvatar(radius: 40),
                ),
                Image.asset('assets/chat popup.png'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
