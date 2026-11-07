import 'package:budgify/features/onboard/model/onboarding_model.dart';
import 'package:flutter/material.dart';

Widget bottomDots(
  List<OnboardingModel> onboardingData,
  int currentPage,
  BuildContext context

) {
  final colorScheme=Theme.of(context).colorScheme;
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(onboardingData.length, (index) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        height: 8.0,
        width: currentPage == index ? 24.0 : 8.0,
        decoration: BoxDecoration(
          color: currentPage == index
              ? colorScheme.primary
              : colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: currentPage == index
                ? colorScheme.surface
                : colorScheme.onSurface,
            width: 1.5,
          ),
        ),
      );
    }),
  );
}
