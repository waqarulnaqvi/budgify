import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  final String label;
  final Color background;
  final Color textColor;
  final VoidCallback onPressed;

  const DialogButton({
    super.key,
    required this.label,
    required this.background,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: background,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
