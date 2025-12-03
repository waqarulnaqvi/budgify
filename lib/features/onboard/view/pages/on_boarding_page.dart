import 'package:budgify/features/expense_tracker/view/widgets/dialog/reusable_dialog_class.dart';
import 'package:budgify/features/onboard/data/onboarding_contents.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/prefs_keys.dart';
import '../../../../core/local/prefs_helper.dart';
import '../../../../core/routes/paths.dart';
import '../../../../shared/view/widgets/global_widgets.dart';
import '../widgets/bottom_dots.dart';
import '../widgets/buttons/reusable_button.dart';
import '../widgets/footer_text.dart';
import '../widgets/next_button.dart';
import '../widgets/top_navigation.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (value,result)=> ReusableDialogClass.showYesNoDialog(context),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              /// Top Navigation Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: topNavigation(
                  _pageController,
                  onboardingContentsList,
                  context,
                ),
              ),
      
              /// Page Controller Section
              pageControllerSection(colorScheme),
              spacerH(15),
      
              ///Dots Section
              bottomDots(onboardingContentsList, _currentPage, context),
              spacerH(20),
      
              ///Button Section
              buttonSection(),
              spacerH(10),
      
              ///footer section
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: footerText(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Page controller Section
  Widget pageControllerSection(ColorScheme colorScheme) => Expanded(
    child: PageView.builder(
      controller: _pageController,
      itemCount: onboardingContentsList.length,
      itemBuilder: (context, index) {
        final page = onboardingContentsList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(page.image, height: 200),
              spacerH(10),
              Text(
                page.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 10),
              Flexible(
                child: Text(
                  page.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ),
              // Bottom content (Page Indicator and Button)
            ],
          ),
        );
      },
    ),
  );

  /// Button Section
  Widget buttonSection() =>
      _currentPage == onboardingContentsList.length - 1
          ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ReusableButton(
              onClick: () async {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Paths.bottomNavBar,
                  (route) => false,
                );
                PrefsHelper prefs = PrefsHelper();
                await prefs.setBoolValue(PrefsKeys.isSeenOnBoard, true);
              },
              text: "Get Started",
            ),
          )
          : NextButton(
            pageController: _pageController,
            totalPages: onboardingContentsList.length,
            currentPage: _currentPage,
            onNext: () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            },
          );
}
