import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:git_tracker/controller/text_controller.dart';

class MyCardRow extends StatelessWidget {
  const MyCardRow({
    super.key,
    required this.imageFirst,
    required this.textFirst,
    required this.imageSecond,
    required this.textSecond

  });
  final String imageFirst;
  final String imageSecond;
  final String textSecond;
  final String textFirst;

  @override
  Widget build(BuildContext context) {
    final controller=Get.find<TextController>();
    return Padding(
      padding: const EdgeInsets.only(left: 30.0),
      child: Row(
        children: [
         Obx(() => GestureDetector(
          onLongPress: controller.toggleSelection,
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: controller.isSelected.value ? Colors.blue : Colors.transparent,
                width: 2,
              ),
            ),
            elevation: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 160,
                  height: 134,
                  child: Image.asset(
                    'assets/$imageFirst.png',
                    height: 20,
                    width: 40,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    textFirst,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
    Obx(() => GestureDetector(
          onLongPress: controller.toggleSelection,
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: controller.isSelected.value ? Colors.blue : Colors.transparent,
                width: 2,
              ),
            ),
            elevation: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 160,
                  height: 134,
                  child: Image.asset(
                    'assets/$imageSecond.png',
                    height: 20,
                    width: 40,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    textSecond,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ))
        ],
      ),
    );
  }
}
