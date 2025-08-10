import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/routes/paths.dart';
import '../../../../shared/view/widgets/global_widgets.dart';
import '../../../core/constants/constants.dart';
import '../model/drawer_model.dart';
import '../view/widgets/dialog/reusable_dialog_class.dart';

List<DrawerModel> drawerContentsList(BuildContext context, WidgetRef ref) => [
      DrawerModel(
          title: "Connect",
          icon: Icons.person,
          onTap: () async {
            if (context.mounted) {
              Navigator.pop(context);
            }
            await ReusableDialogClass.connectUsDialog(context);
          }),
      DrawerModel(
          title: "More apps",
          icon: Icons.shopping_cart,
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, Paths.moreAppsPage);
          }),
      DrawerModel(
        title: "Share",
        icon: Icons.leaderboard,
        onTap: () async {
          if (context.mounted) {
            Navigator.pop(context);
          }
          await shareAppLink();
        },
      ),
      DrawerModel(
          title: "Mail",
          icon: Icons.feedback_outlined,
          onTap: () {
            openUrl(
                url:
                    "mailto:mysteriouscoderofficial@gmail.com?subject=Feedback",
                context: context,
                isExternal: true);
            Navigator.pop(context);
          }),
      DrawerModel(
          title: "Rate",
          icon: Icons.description_outlined,
          onTap: () {
            openUrl(
                url:
                    "https://play.google.com/store/apps/details?id=com.mysteriouscoder.budgetflow",
                context: context);
            Navigator.pop(context);
          }),
  DrawerModel(
      title: "Feedback Form",
      icon: Icons.feedback_outlined,
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, Paths.googleFormsInAppWebView);
      }),
      DrawerModel(
          title: "Privacy Policy",
          icon: Icons.privacy_tip,
          onTap: () {
            Navigator.pop(context);
            openUrl(
                url: 'https://mysteriouscoder.com/privacypolicy/',
                context: context);
          }),
      DrawerModel(
          title: "Exit",
          icon: Icons.logout,
          onTap: () async {
            if (context.mounted) {
              Navigator.pop(context);
            }
            await ReusableDialogClass.showYesNoDialog(context);
          }),
    ];

Future<void> shareAppLink() async {
  try {
    final String message =
        "Discover a powerful solution for managing your expenses and budget effectively:\n\n${Constants.budgetFlowUrl}";
    await Share.share(message);
  } catch (e) {
    if (kDebugMode) {
      print('Error sharing app link: $e');
    }
  }
}
