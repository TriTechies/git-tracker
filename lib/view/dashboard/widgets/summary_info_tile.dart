import 'package:flutter/material.dart';

class SummaryInfoTile extends StatelessWidget {
  final String title;
  final String value;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;

  const SummaryInfoTile({
    super.key,
    required this.title,
    required this.value,
    this.icon,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey, // Use textColor if provided
            ),
          ),
          const SizedBox(height: 4),
          Container(
            decoration: BoxDecoration(
              color: backgroundColor ?? Colors.transparent,
              borderRadius: BorderRadius.circular(8.0), // Rounded border
            ),
            padding: backgroundColor != null
                ? const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0)
                : EdgeInsets.zero,
            child: Row(
              mainAxisSize: MainAxisSize.min, // Fit width to content
              children: [
                if (icon != null)
                  Icon(
                    icon,
                    color: textColor ?? Colors.black,
                    size: 20.0,
                  ),
                if (icon != null) const SizedBox(width: 8),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 18, // Larger font size for the value
                    fontWeight: FontWeight.bold,
                    color:
                        textColor ?? Colors.black, // Use textColor if provided
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
