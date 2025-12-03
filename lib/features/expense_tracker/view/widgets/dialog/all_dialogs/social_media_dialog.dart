import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../../core/constants/constants.dart';
import '../../../../../../core/theme/app_gradients.dart';
import '../../../../../../shared/view/widgets/buttons/reusable_icon_button.dart';
import '../../../../../../shared/view/widgets/global_widgets.dart';

class SocialMediaDialog extends StatelessWidget {
  const SocialMediaDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [

        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            FontAwesomeIcons.shareNodes,
            size: 38,
            color: colorScheme.primary,
          ),
        ),

        spacerH(),

        Text(
          "Social Media",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),

        spacerH(10),

        Text(
          "Connect with us on social media",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: colorScheme.onSurface,fontWeight: FontWeight.w500),
        ),


        spacerH(28),
        Row(
          children: [
            Expanded(
              child: ReusableIconButton(
                title: 'Youtube',
                socialIconSize: 20,
                icon: FontAwesomeIcons.youtube,
                colors: AppGradients.youtubeGradient,
                url: Constants.youtubeLink,
              ),
            ),
            spacerW(12),
            Expanded(
              child: ReusableIconButton(
                title: 'Instagram',
                socialIconSize: 18,
                spacerWidth: 4,
                icon: FontAwesomeIcons.instagram,
                colors: AppGradients.instagramGradient,
                url: Constants.instagramLink,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
