import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:git_tracker/controller/text_controller.dart';

class MyCardRow extends StatelessWidget {
  const MyCardRow({
    super.key,
    required this.image,
    required this.text,
  });

  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TextController>();

    return Padding(
      padding: const EdgeInsets.only(left: 30.0),
      child: Obx(() => GestureDetector(
            onLongPress: () => controller.toggleSelection(text),
            onTap: () => controller.isInSelectionMode.value
                ? controller.toggleSelection(text)
                : null,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: controller.isCardSelected(text)
                      ? Colors.blue
                      : Colors.transparent,
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
                      'assets/$image.png',
                      height: 20,
                      width: 40,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      text,
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
    );
  }
}
