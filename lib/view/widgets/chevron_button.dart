import 'package:flutter/material.dart';

class ChevronButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String direction;
  final IconData? icon;

  const ChevronButton({
    super.key,
    required this.onPressed,
    required this.direction,
    this.icon,
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color.fromARGB(255, 234, 236, 240),
          width: 1,
        ),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: RotatedBox(
          quarterTurns: _getQuarterTurns(),
          child: Icon(_getChevronIcon()),
        ),
      ),
    );
  }
}
