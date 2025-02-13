import 'package:flutter/material.dart';

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
    return Padding(
      padding: const EdgeInsets.only(left: 30.0),
      child: Row(
        children: [
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 160,
                  height: 134,
                  child: SizedBox(
                    height: 20,
                    width: 40,
                    child: Image.asset(
                      'assets/$imageFirst.png',
                      fit: BoxFit.contain,
                    ),
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
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
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
                    fit: BoxFit.contain,
                  ),
                ),
                 Padding(
                  padding:const  EdgeInsets.all(8.0),
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
        ],
      ),
    );
  }
}
