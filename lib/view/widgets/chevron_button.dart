import 'package:flutter/material.dart';

class ChevronButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String direction;
  final IconData? icon;
  final Color? backgroundColor;
  final bool? showBackgroundColor;

  const ChevronButton({
    super.key,
    required this.onPressed,
    required this.direction,
    this.icon,
    this.backgroundColor,
    this.showBackgroundColor = false,
  });

  IconData _getChevronIcon() {
    if (icon != null) return icon!;

    return switch (direction.toLowerCase()) {
      'left' => Icons.chevron_left,
      _ => Icons.chevron_right,
    };
  }

  int _getQuarterTurns() {
    return switch (direction.toLowerCase()) {
      'up' => -1,
      'down' => 1,
      _ => 0,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: (showBackgroundColor ?? false)
          ? (backgroundColor ?? Colors.transparent)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color.fromARGB(255, 234, 236, 240),
              width: 1,
            ),
          ),
          child: Center(
            child: RotatedBox(
              quarterTurns: _getQuarterTurns(),
              child: Icon(_getChevronIcon()),
            ),
          ),
        ),
      ),
    );
  }
}
