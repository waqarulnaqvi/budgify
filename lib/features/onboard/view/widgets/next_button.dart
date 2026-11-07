import 'package:flutter/material.dart';

class NextButton extends StatefulWidget {
  final PageController pageController;
  final int totalPages;
  final int currentPage;
  final VoidCallback onNext;

  const NextButton({
    super.key,
    required this.pageController,
    required this.totalPages,
    required this.currentPage,
    required this.onNext,
  });

  @override
  State<NextButton> createState() => _NextButtonState();
}

class _NextButtonState extends State<NextButton> {
  @override
  Widget build(BuildContext context) {
    final colorScheme= Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: widget.onNext,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 60.0,
            height: 60.0,
            child: CircularProgressIndicator(
              value: (widget.currentPage + 1) / widget.totalPages,
              color: colorScheme.primary,
              strokeWidth: 3.0,
            ),
          ),
          Container(
            width: 49.0,
            height: 49.0,
            decoration: BoxDecoration(
              color: colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.keyboard_double_arrow_right,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
