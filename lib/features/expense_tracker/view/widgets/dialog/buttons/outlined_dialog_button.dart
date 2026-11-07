import 'package:flutter/material.dart';

class OutlinedDialogButton extends StatelessWidget {
  final String label;
  final Color borderColor;
  final Color? backgroundColor;
  final VoidCallback onPressed;

  const OutlinedDialogButton({
    super.key,
    this.backgroundColor,
    required this.label,
    required this.borderColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          width: 1.5,
          color: borderColor
        ),
        backgroundColor: backgroundColor?? (isDark?Colors.grey.shade700 :Colors.grey.shade100),
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
          color: borderColor,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
