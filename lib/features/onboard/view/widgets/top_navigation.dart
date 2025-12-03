import 'package:budgify/features/onboard/model/onboarding_model.dart';
import 'package:flutter/material.dart';

Widget topNavigation(
  PageController pageController,
  List<OnboardingModel> onboardingData,
    BuildContext context
) {
  final colorScheme=Theme.of(context).colorScheme;
  int currentPage = pageController.hasClients ? pageController.page?.round() ?? 0 : 0;

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [

      Opacity(
        opacity: currentPage != 0 ? 1.0 : 0.0, // Visible if not first page
        child: IgnorePointer(
          ignoring: currentPage == 0, // Disable clicks when on first page
          child: IconButton(
            icon: Icon(Icons.arrow_back, size: 20, color: colorScheme.onSurface),
            onPressed: () {
              pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            },
          ),
        ),
      ),


      if (currentPage != onboardingData.length - 1)
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: GestureDetector(
          onTap: () {
            pageController.jumpToPage(onboardingData.length - 1);
          },
          child: Text(
            'Skip',
            style: TextStyle(
              decoration: TextDecoration.underline,
              decorationColor: colorScheme.primary,
              fontSize: 16,
              color: colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    ],
  );
}