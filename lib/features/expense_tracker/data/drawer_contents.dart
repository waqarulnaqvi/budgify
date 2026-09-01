import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/routes/paths.dart';
import '../../../../shared/view/widgets/global_widgets.dart';
import '../../../core/constants/constants.dart';
import '../model/drawer_model.dart';
import '../view/widgets/dialog/reusable_dialog_class.dart';

List<DrawerModel> drawerContentsList(BuildContext context, WidgetRef ref) => [
  DrawerModel(
    title: "App Tour",
    faIcon:  FontAwesomeIcons.route,
    onTap: () {
      Navigator.pop(context);
      Navigator.pushNamedAndRemoveUntil(
        context,
        Paths.onboardingPage,
        (route) => false,
      );
      // your onboarding route
    },
  ),

  DrawerModel(
    title: "Connect",
    icon: Icons.person,
    onTap: () async {
      Navigator.pop(context);
      await ReusableDialogClass.connectUsDialog(context);
    },
  ),
  DrawerModel(
    title: "More apps",
    icon: Icons.shopping_cart,
    onTap: () {
      Navigator.pop(context);
      Navigator.pushNamed(context, Paths.moreAppsPage);
    },
  ),
  DrawerModel(
    title: "Share",
    icon: Icons.leaderboard,
    onTap: () async {
      Navigator.pop(context);
      await shareAppLink();
    },
  ),
  DrawerModel(
    title: "Mail",
    icon: Icons.feedback_outlined,
    onTap: () async {
      Navigator.pop(context);
      await openUrl(
        url: "mailto:mysteriouscoderofficial@gmail.com?subject=Feedback",
        context: context,
        isExternal: true,
      );
    },
  ),
  DrawerModel(
    title: "Rate",
    icon: Icons.description_outlined,
    onTap: () async {
      Navigator.pop(context);
      await openUrl(url: AppConstants.budgetFlowUrl, context: context);
    },
  ),
  DrawerModel(
    title: "Feedback Form",
    icon: Icons.feedback_outlined,
    onTap: () {
      Navigator.pop(context);
      Navigator.pushNamed(context, Paths.googleFormsInAppWebView);
    },
  ),
  DrawerModel(
    title: "Privacy Policy",
    icon: Icons.privacy_tip,
    onTap: () async {
      Navigator.pop(context);
      await openUrl(url: AppConstants.budgetFlowPrivacyPolicy, context: context);
    },
  ),
  DrawerModel(
    title: "Exit",
    icon: Icons.logout,
    onTap: () async {
      Navigator.pop(context);
      await ReusableDialogClass.showYesNoDialog(context);
    },
  ),
];

Future<void> shareAppLink() async {
  try {
    final String message =
        "Discover a powerful solution for managing your expenses and budget effectively:\n\n${AppConstants.budgetFlowUrl}";
    await Share.share(message);
  } catch (e) {
    if (kDebugMode) {
      print('Error sharing app link: $e');
    }
  }
}
