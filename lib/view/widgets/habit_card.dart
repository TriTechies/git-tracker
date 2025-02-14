import 'package:flutter/material.dart';
import 'package:git_tracker/view/style/style.dart';

class HabitCard extends StatelessWidget {
  const HabitCard({
    super.key,
    required this.heading,
    required this.image,
    required this.subHeading,
  });
  final String image;
  final String heading;
  final String subHeading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        elevation: 4,
        child: SizedBox(
          height: 64,
          width: 360,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/$image.png',
                    height: 32,
                    width: 32,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        heading,
                        style: defaultstyle(
                          fontFamily: "Segoe UI",
                          size: 14,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subHeading,
                        style: withoutFontWeight(
                          fontFamily: "Segoe UI",
                          size: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey.shade300,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add, size: 18),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
