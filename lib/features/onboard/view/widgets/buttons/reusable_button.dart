import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  final VoidCallback onClick;
  final String text;
  final bool isShowEndIcon;

  const ReusableButton({
    super.key,
    required this.onClick,
    required this.text,
    this.isShowEndIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme=Theme.of(context).colorScheme;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        onPressed: onClick,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            if (isShowEndIcon)
              const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
          ],
        ),
      ),
    );
  }
}
