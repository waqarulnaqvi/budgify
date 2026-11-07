import 'package:flutter/material.dart';

class CommonDialogWidget extends StatelessWidget {
  final Widget child;
  const CommonDialogWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            child: Container(
              margin: const EdgeInsets.only(top: 80),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isDark ?Color(0xFF2C2C2C)   : Colors.white ,
                borderRadius: BorderRadius.circular(20),
              ),
              child: child
            ),
          ),

          // TOP CIRCULAR CLOSE ICON
          Positioned(
            right: 0,
            child: GestureDetector(
              onTap: ()=> Navigator.pop(context, false),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.close,
                  color: colorScheme.primary,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
